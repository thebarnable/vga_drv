library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end top_tb;

architecture behav of top_tb is
  signal clk, rstn : std_logic := '0';
  signal vga_r, vga_g, vga_b  : unsigned(3 downto 0);
  signal vga_hs, vga_vs       : std_logic;

  constant CLK_PERIOD : time := 10 ns;
begin
  -- Instantiation
  dut : entity work.top(rtl)
    port map
    (
      CLK100MHZ   => clk,
      CPU_RESETN  => rstn,
      VGA_R       => vga_r,
      VGA_G       => vga_g,
      VGA_B       => vga_b,
      VGA_HS      => vga_hs,
      VGA_VS      => vga_vs
    );

  -- Clock & Reset
  clk_proc : process
  begin
    while true loop
      clk <= '0';
      wait for CLK_PERIOD / 2;
      clk <= '1';
      wait for CLK_PERIOD / 2;
    end loop;
  end process;

  reset_proc : process
  begin
    rstn <= '0';
    wait for 3*CLK_PERIOD;
    rstn <= '1';
    wait;
  end process;

  -- Stimulus & Test
  stim_proc: process
  begin
    wait for 3*CLK_PERIOD;
    assert (vga_hs = '0')
      report "Horizontal sync wrong" severity error;
    wait;
  end process;
end behav;
