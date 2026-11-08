library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_alu is
end tb_alu;

architecture sim of tb_alu is
    signal A, B, R_sel, R_if : std_logic_vector(7 downto 0);
    signal OP : std_logic_vector(2 downto 0);

    function expected(x, y : std_logic_vector(7 downto 0);
                      sel : std_logic_vector(2 downto 0)) return std_logic_vector is
    begin
        case sel is
            when "000"  => return "00000000";
            when "001"  => return std_logic_vector(unsigned(x) - unsigned(y));
            when "010"  => return std_logic_vector(unsigned(x) + unsigned(y));
            when "011"  => return x and y;
            when "100"  => return x or y;
            when "101"  => return x xor y;
            when "110"  => return not x;
            when others => return "11111111";
        end case;
    end function;
begin
    dut_select : entity work.alu    port map (A => A, B => B, OP => OP, R => R_sel);
    dut_if     : entity work.alu_if port map (A => A, B => B, OP => OP, R => R_if);

    process
        variable errors : natural := 0;
        variable exp    : std_logic_vector(7 downto 0);
    begin
        for o in 0 to 7 loop
            for i in 0 to 255 loop
                for j in 0 to 255 loop
                    A  <= std_logic_vector(to_unsigned(i, 8));
                    B  <= std_logic_vector(to_unsigned(j, 8));
                    OP <= std_logic_vector(to_unsigned(o, 3));
                    wait for 1 ns;
                    exp := expected(A, B, OP);
                    if R_sel /= exp or R_if /= exp then
                        errors := errors + 1;
                        report "Mismatch: OP=" & integer'image(o) & " A=" & integer'image(i)
                             & " B=" & integer'image(j) severity error;
                    end if;
                end loop;
            end loop;
        end loop;

        A <= "00001001"; B <= "00000000";
        OP <= "110"; wait for 1 ns;
        assert R_sel = "11110110" report "not A failed for A = 9" severity error;

        if errors = 0 then
            report "ALU PASSED: all 524288 input combinations correct for both ALU versions";
        else
            report "ALU FAILED: " & integer'image(errors) & " mismatches" severity failure;
        end if;
        wait;
    end process;
end sim;
