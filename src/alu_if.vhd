library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_if is
    Port ( A  : in  std_logic_vector(7 downto 0);
           B  : in  std_logic_vector(7 downto 0);
           OP : in  std_logic_vector(2 downto 0);
           R  : out std_logic_vector(7 downto 0));
end alu_if;

architecture Behavioral of alu_if is
begin
    process (A, B, OP)
    begin
        if OP = "000" then
            R <= "00000000";
        elsif OP = "001" then
            R <= A - B;
        elsif OP = "010" then
            R <= A + B;
        elsif OP = "011" then
            R <= A and B;
        elsif OP = "100" then
            R <= A or B;
        elsif OP = "101" then
            R <= A xor B;
        elsif OP = "110" then
            R <= not A;
        elsif OP = "111" then
            R <= "11111111";
        else
            R <= "ZZZZZZZZ";
        end if;
    end process;
end Behavioral;
