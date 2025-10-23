library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    CLK100MHZ   : in std_logic;
    CPU_RESETN  : in std_logic;
    VGA_R       : out unsigned(3 downto 0);
    VGA_G       : out unsigned(3 downto 0);
    VGA_B       : out unsigned(3 downto 0);
    VGA_HS      : out std_logic;
    VGA_VS      : out std_logic
  );
end top;

architecture rtl of top is
  signal CLK25MHZ : std_logic;
  signal clk_cnt  : unsigned(1 downto 0);
  signal hor_cnt : unsigned(9 downto 0);
  signal ver_cnt : unsigned(9 downto 0);

  constant HOR_SYNC_TIME    : integer := 96;
  constant HOR_BACK_PORCH   : integer := 48;
  constant HOR_ADDR_VIDEO   : integer := 640;
  constant HOR_FRONT_PORCH  : integer := 16;

  constant VER_SYNC_TIME    : integer := 2;
  constant VER_BACK_PORCH   : integer := 33;
  constant VER_ADDR_VIDEO   : integer := 480;
  constant VER_FRONT_PORCH  : integer := 10;

  constant HOR_PIXELS : integer := HOR_SYNC_TIME + HOR_BACK_PORCH + HOR_ADDR_VIDEO + HOR_FRONT_PORCH; --- 800
  constant VER_LINES  : integer := VER_SYNC_TIME + VER_BACK_PORCH + VER_ADDR_VIDEO + VER_FRONT_PORCH; --- 525
begin
  --- clock divider
  process(CLK100MHZ)
  begin
    if rising_edge(CLK100MHZ) then
      clk_cnt <= clk_cnt + 1;
      CLK25MHZ <= clk_cnt(1);
    end if;
  end process;

  --- state machine
  -- horizontal pixel counter
  process(CLK25MHZ)
  begin
    if rising_edge(CLK25MHZ) then
      if (CPU_RESETN = '0') or hor_cnt = to_unsigned(HOR_PIXELS-1, hor_cnt'length) then
        hor_cnt <= (others => '0');
      else
        hor_cnt <= hor_cnt + 1;
      end if;
    end if;
  end process;

  VGA_HS <= '1' when hor_cnt < to_unsigned(HOR_SYNC_TIME, hor_cnt'length) else '0';

  -- vertical line counter
  process(CLK25MHZ)
  begin
    if rising_edge(CLK25MHZ) then
      if (CPU_RESETN = '0') or ver_cnt = to_unsigned(VER_LINES-1, ver_cnt'length) then
        ver_cnt <= (others => '0');
      else 
        if hor_cnt = to_unsigned(HOR_PIXELS-1, hor_cnt'length) then
          ver_cnt <= ver_cnt + 1;
        end if;
      end if;
    end if;
  end process;

  VGA_VS <= '1' when ver_cnt < to_unsigned(VER_SYNC_TIME, ver_cnt'length) else '0';

  --- data path
  VGA_R <= (others => hor_cnt(3));
  VGA_G <= (others => hor_cnt(3));
  VGA_B <= (others => hor_cnt(3));
end rtl;
