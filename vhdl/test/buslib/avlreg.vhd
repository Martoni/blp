-------------------------------------------------------
-- Fabien Marteau <mail@fabienm.eu
-- 11/04/2015
-------------------------------------------------------
-- Simple avalon-MM register with byteenable management
-- and readonly ID register
-------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

Entity avlreg is
    port(
            clk : in std_logic;
            rst : in std_logic;
            -- avalon-mm
            write : in std_logic;
            read  : in std_logic;
            addr  : in std_logic_vector(0 downto 0);
            datawrite : in std_logic_vector(63 downto 0);
            dataread  : out std_logic_vector(63 downto 0);
            byteenable: in std_logic_vector(7 downto 0)
        );
end entity avlreg;

architecture avlreg_1 of avlreg is

    constant AVL_ID : std_logic_vector(63 downto 0) := x"DEADBEEFCAFEDECA";
    signal avlregister : std_logic_vector(63 downto 0);

begin

    read_proc : process(clk, rst)
    begin
        if (rst = '1') then
            dataread <= (others => '0');
        elsif rising_edge(clk) then
            if (read = '1') then
                case addr is
                   when "0" => -- AVL_ID
                        for i in 0 to 7 loop
                            if byteenable(i) = '1' then
                                dataread((7 + i * 8) downto (i * 8)) <=
                                        AVL_ID((7 + i * 8) downto (i * 8));
                            end if;
                        end loop;
                   when "1" => -- avlregister
                        for i in 0 to 7 loop
                            if byteenable(i) = '1' then
                                dataread((7 + i * 8) downto (i * 8)) <=
                                        avlregister((7 + i * 8) downto (i * 8));
                            end if;
                        end loop;
                   when others =>
                            dataread <= (others => '0');
                end case;
            end if;
        end if;
    end process read_proc;

    write_proc : process(clk, rst)
    begin
        if (rst = '1') then
            avlregister <= (others => '0');
        elsif rising_edge(clk) then
            if (write = '1') then
                case addr is
                   when "1" => -- avlregister
                        for i in 0 to 7 loop
                            if byteenable(i) = '1' then
                                avlregister((7 + i * 8) downto (i * 8)) <=
                                        datawrite((7 + i * 8) downto (i * 8));
                            end if;
                        end loop;
                   when others =>
                       avlregister <= avlregister;
                end case;
            end if;
        end if;
    end process write_proc;

end architecture avlreg_1;
