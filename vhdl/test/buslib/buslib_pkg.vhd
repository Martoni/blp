---------------------------------------------
-- Test avalonmm read/write 
-- Fabien Marteau <fabien.marteau@armadeus.com>
---------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

package buslib_pkg is

    procedure avlmm_write(
            -- parameters
            address     : in natural;
            value       : in std_logic_vector;
            -- controled signals
            signal clk       : in std_logic;
            signal write     : out std_logic;
            signal addr      : out std_logic_vector;
            signal datawrite : out std_logic_vector;
            signal byteenable: out std_logic_vector 
    );

end package buslib_pkg;

package body buslib_pkg is

    procedure avlmm_write(
            -- parameters
            address     : in natural;
            value       : in std_logic_vector;
            -- controled signals
            signal clk       : in std_logic;
            signal write     : out std_logic;
            signal addr      : out std_logic_vector;
            signal datawrite : out std_logic_vector;
            signal byteenable: out std_logic_vector 
    ) is begin
        assert byteenable'length = (datawrite'length)/8
            report "Error byteenable size";
        wait until rising_edge(clk);
        write <= '1';
        addr  <= std_logic_vector(to_unsigned(address, 1));
        wait until rising_edge(clk);
        write <= '0';
    end procedure avlmm_write;

end package body buslib_pkg;
