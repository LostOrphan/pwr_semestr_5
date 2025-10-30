-- Vhdl test bench created from schematic C:\Users\lab\Documents\280878\lab1_gr11_cw1\lab1_gr11_cw1.sch - Wed Oct 15 15:45:41 2025
--
-- Notes: 
-- 1) This testbench template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the unit under test.
-- Xilinx recommends that these types always be used for the top-level
-- I/O of a design in order to guarantee that the testbench will bind
-- correctly to the timing (post-route) simulation model.
-- 2) To use this template as your testbench, change the filename to any
-- name of your choice with the extension .vhd, and use the "Source->Add"
-- menu in Project Navigator to import the testbench. Then
-- edit the user defined section below, adding code to generate the 
-- stimulus for your design.
--
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
LIBRARY UNISIM;
USE UNISIM.Vcomponents.ALL;
ENTITY lab1_gr11_cw1_lab1_gr11_cw1_sch_tb IS
END lab1_gr11_cw1_lab1_gr11_cw1_sch_tb;
ARCHITECTURE behavioral OF lab1_gr11_cw1_lab1_gr11_cw1_sch_tb IS 

   COMPONENT lab1_gr11_cw1
   PORT( Key	:	IN	STD_LOGIC_VECTOR (3 DOWNTO 0); 
          LED	:	OUT	STD_LOGIC_VECTOR (4 DOWNTO 0); 
          D7S_S	:	OUT	STD_LOGIC_VECTOR (6 DOWNTO 0));
   END COMPONENT;

   SIGNAL Key	:	STD_LOGIC_VECTOR (3 DOWNTO 0);
   SIGNAL LED	:	STD_LOGIC_VECTOR (4 DOWNTO 0);
   SIGNAL D7S_S	:	STD_LOGIC_VECTOR (6 DOWNTO 0);

BEGIN

   UUT: lab1_gr11_cw1 PORT MAP(
		Key => Key, 
		LED => LED, 
		D7S_S => D7S_S
   );

-- *** Test Bench - User Defined Section ***
   tb : PROCESS
   BEGIN
	Key<="0000";
	wait for 100 ns;
		Key<="0001";
	wait for 100 ns;
		Key<="0010";
	wait for 100 ns;
		Key<="0011";
	wait for 100 ns;
		Key<="0100";
	wait for 100 ns;
		Key<="0101";
	wait for 100 ns;
		Key<="0110";
	wait for 100 ns;
		Key<="0111";
	wait for 100 ns;
		Key<="1000";
	wait for 100 ns;
		Key<="1001";
	wait for 100 ns;
		Key<="1010";
	wait for 100 ns;
		Key<="1011";
	wait for 100 ns;
		Key<="1100";
	wait for 100 ns;
		Key<="1101";
	wait for 100 ns;
		Key<="1110";
	wait for 100 ns;
		Key<="1111";
	wait for 100 ns;
   WAIT; -- will wait forever
   END PROCESS;
-- *** End Test Bench - User Defined Section ***

END;
