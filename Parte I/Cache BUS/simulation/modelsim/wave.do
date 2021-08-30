onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MaquinaEstadoBUS/clock
add wave -noupdate /MaquinaEstadoBUS/MSI
add wave -noupdate /MaquinaEstadoBUS/newState
add wave -noupdate /MaquinaEstadoBUS/state
add wave -noupdate /MaquinaEstadoBUS/invalid
add wave -noupdate /MaquinaEstadoBUS/exclusive
add wave -noupdate /MaquinaEstadoBUS/shared
add wave -noupdate /MaquinaEstadoBUS/read_miss
add wave -noupdate /MaquinaEstadoBUS/write_miss
add wave -noupdate /MaquinaEstadoBUS/invalidate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49 ps} 0}
quietly wave cursor active 1
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
WaveRestoreZoom {0 ps} {1 ns}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 50ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 11 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/MSI 
wave create -driver freeze -pattern clock -initialvalue St1 -period 25ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 10 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/MSI 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
