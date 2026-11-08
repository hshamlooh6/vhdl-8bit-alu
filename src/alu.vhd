library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu is
    Port ( A  : in  std_logic_vector(7 downto 0);
           B  : in  std_logic_vector(7 downto 0);
           OP : in  std_logic_vector(2 downto 0);
           R  : out std_logic_vector(7 downto 0));
end alu;

architecture Behavioral of alu is
begin
    with OP select
        R <= "00000000" when "000",
             A - B      when "001",
             A + B      when "010",
             A and B    when "011",
             A or B     when "100",
             A xor B    when "101",
             not A      when "110",
             "11111111" when "111",
             "ZZZZZZZZ" when others;
end Behavioral;
