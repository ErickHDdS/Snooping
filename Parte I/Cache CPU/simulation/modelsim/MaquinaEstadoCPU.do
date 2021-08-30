onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /MaquinaEstadoCPU/clock
add wave -noupdate -color {Orange Red} /MaquinaEstadoCPU/MSI
add wave -noupdate -color Cyan /MaquinaEstadoCPU/newState
add wave -noupdate -color Magenta /MaquinaEstadoCPU/state
add wave -noupdate -color Yellow /MaquinaEstadoCPU/invalid
add wave -noupdate -color Yellow /MaquinaEstadoCPU/exclusive
add wave -noupdate -color Yellow /MaquinaEstadoCPU/shared
add wave -noupdate -color Yellow /MaquinaEstadoCPU/read_miss
add wave -noupdate -color Yellow /MaquinaEstadoCPU/write_miss
add wave -noupdate -color Yellow /MaquinaEstadoCPU/read_hit
add wave -noupdate -color Yellow /MaquinaEstadoCPU/write_hit
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {50 ps} {1050 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 50ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoCPU/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 11 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoCPU/MSI 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
