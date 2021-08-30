library verilog;
use verilog.vl_types.all;
entity MaquinaEstadoCPU is
    port(
        clock           : in     vl_logic;
        newState        : out    vl_logic_vector(1 downto 0);
        MSI             : in     vl_logic_vector(1 downto 0)
    );
end MaquinaEstadoCPU;
