library ieee;
use ieee.std_logic_1164.all;

entity top_tb is
end top_tb;

architecture behav of top_tb is
  signal i1, i2, o1 : std_logic := '0';
begin
  -- Instantiation
  dut : entity work.top(rtl)
    port map
    (
      i1 => i1,
      i2 => i2,
      o1 => o1
    );

  -- Stimulus
  stim_proc: process
  begin
    i1 <= '0';
    i2 <= '0';
    wait for 10 ns;
    assert (o1 = '0')
      report "Test case 00 failed" severity failure;

    i1 <= '0';
    i2 <= '1';
    wait for 10 ns;
    assert (o1 = '0')
      report "Test case 01 failed" severity failure;

    i1 <= '1';
    i2 <= '0';
    wait for 10 ns;
    assert (o1 = '0')
      report "Test case 10 failed" severity failure;

    i1 <= '1';
    i2 <= '1';
    wait for 10 ns;
    assert (o1 = '1')
      report "Test case 11 failed" severity failure;

    
    report "All tests passed successfully!" severity note;
    wait for 10 ns;
    wait;
  end process;
end behav;
