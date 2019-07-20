library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.video.all;

entity video_top is
  port (
    clk : in std_logic;
    led : out std_logic_vector(7 downto 0)
  );
end video_top;

architecture arch of video_top is
  signal video_pos   : position_t;
  signal video_sync  : sync_t;
  signal video_blank : blank_t;
begin
  -- video timing generator
  sync_gen : entity work.sync_gen
  port map (
    clk   => clk,
    cen   => '1',
    pos   => video_pos,
    sync  => video_sync,
    blank => video_blank
  );

  counter : process (clk)
    variable n : unsigned(31 downto 0);
  begin
    if rising_edge(clk) then
      n := n + 1;
      led <= std_logic_vector(n(31 downto 24));
    end if;
  end process;
end arch;
