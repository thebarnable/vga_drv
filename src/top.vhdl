library ieee;
use ieee.std_logic_1164.all;

entity top is
  port (
    i1 : in std_logic;
    i2 : in std_logic;
    o1 : out std_logic
  );
end top;

architecture rtl of top is
  signal and_gate : std_logic;
begin
  and_gate <= i1 and i2;
  o1       <= and_gate;
end rtl;
