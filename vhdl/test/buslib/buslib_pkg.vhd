---------------------------------------------
-- Test avalonmm read/write
-- Fabien Marteau <fabien.marteau@armadeus.com>
---------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.math_real.all;

package buslib_pkg is

    procedure avlmm_write8(
            -- parameters
            address     : in natural;
            value       : in std_logic_vector(7 downto 0);
            writeWaitTime : in natural;
            -- controled signals
            signal clk       : in std_logic;
            signal write     : out std_logic;
            signal addr      : out std_logic_vector;
            signal datawrite : out std_logic_vector;
            signal byteenable: out std_logic_vector);

    procedure avlmm_read8(
            -- parameters
            address : in natural;
            value   : out std_logic_vector(7 downto 0);
            readWaitTime : in natural;
            -- controled signals
            signal clk       : in std_logic;
            signal read      : out std_logic;
            signal addr      : out std_logic_vector;
            signal dataread  : in std_logic_vector;
            signal byteenable: out std_logic_vector);

    CONSTANT ZERO : std_logic_vector(63 downto 0) := x"0000000000000000";

end package buslib_pkg;

package body buslib_pkg is

    procedure avlmm_write8(
            -- parameters
            address : in natural;
            value   : in std_logic_vector(7 downto 0);
            writeWaitTime : in natural;
            -- controled signals
            signal clk       : in std_logic;
            signal write     : out std_logic;
            signal addr      : out std_logic_vector;
            signal datawrite : out std_logic_vector;
            signal byteenable: out std_logic_vector
    ) is
        variable data_word_size : natural := (datawrite'length)/8;
        variable byte_pos : natural := address mod data_word_size;
        variable addrtailsize : natural :=
                        natural(ceil(log2(real(data_word_size))));
        variable addr_full :
                    std_logic_vector(addr'length + addrtailsize -1 downto 0);
    begin
        assert byteenable'length = data_word_size
            report "Error byteenable size "
                    & integer'image(byteenable'length) &
                    " Must be " & integer'image(data_word_size);
        addr_full := std_logic_vector(
                        to_unsigned(address,
                           (addr'length) + addrtailsize));
        wait until rising_edge(clk);
        write <= '1';
        addr <= addr_full(addr_full'length - 1 downto addrtailsize);
        byteenable(byte_pos) <= '1';
        datawrite(7 + byte_pos*8 downto byte_pos*8) <= value;
        for i in 0 to writeWaitTime loop
            wait until rising_edge(clk);
        end loop;

        datawrite(7 + byte_pos*8 downto byte_pos*8) <= (others => '0');
        write <= '0';
        addr <= ZERO(addr_full'length - 1 downto addrtailsize);
        byteenable <= ZERO(byteenable'length - 1 downto 0);
    end procedure avlmm_write8;

    procedure avlmm_read8(
            -- parameters
            address : in natural;
            value   : out std_logic_vector(7 downto 0);
            readWaitTime : in natural;
            -- controled signals
            signal clk       : in std_logic;
            signal read      : out std_logic;
            signal addr      : out std_logic_vector;
            signal dataread  : in std_logic_vector;
            signal byteenable: out std_logic_vector
    ) is
        variable data_word_size : natural := (dataread'length)/8;
        variable byte_pos : natural := address mod data_word_size;
        variable addrtailsize : natural :=
                        natural(ceil(log2(real(data_word_size))));
        variable addr_full :
                    std_logic_vector(addr'length + addrtailsize -1 downto 0);
    begin
        assert byteenable'length = data_word_size
            report "Error byteenable size "
                    & integer'image(byteenable'length) &
                    " Must be " & integer'image(data_word_size);
        addr_full := std_logic_vector(
                        to_unsigned(address,
                           (addr'length) + addrtailsize));
        wait until rising_edge(clk);
        read <= '1';
        addr <= addr_full(addr_full'length - 1 downto addrtailsize);
        byteenable(byte_pos) <= '1';
        for i in 0 to readWaitTime loop
            wait until rising_edge(clk);
        end loop;

        value := dataread(7 + byte_pos*8 downto byte_pos*8);
        read <= '0';
        addr <= ZERO(addr_full'length - 1 downto addrtailsize);
        byteenable <= ZERO(byteenable'length - 1 downto 0);
    end procedure avlmm_read8;


end package body buslib_pkg;
