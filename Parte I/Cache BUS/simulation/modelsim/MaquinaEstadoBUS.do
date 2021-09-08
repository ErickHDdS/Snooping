onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MaquinaEstadoBUS/clock
add wave -noupdate /MaquinaEstadoBUS/MSI
add wave -noupdate -divider State
add wave -noupdate -color Cyan -subitemconfig {{/MaquinaEstadoBUS/newState[1]} {-color Cyan} {/MaquinaEstadoBUS/newState[0]} {-color Cyan}} /MaquinaEstadoBUS/newState
add wave -noupdate -color Magenta -subitemconfig {{/MaquinaEstadoBUS/state[1]} {-color Magenta} {/MaquinaEstadoBUS/state[0]} {-color Magenta}} /MaquinaEstadoBUS/state
add wave -noupdate -color Yellow /MaquinaEstadoBUS/invalid
add wave -noupdate -color Yellow /MaquinaEstadoBUS/exclusive
add wave -noupdate -color Yellow /MaquinaEstadoBUS/shared
add wave -noupdate -divider Message
add wave -noupdate -color Red -subitemconfig {{/MaquinaEstadoBUS/mensage[1]} {-color Red} {/MaquinaEstadoBUS/mensage[0]} {-color Red}} /MaquinaEstadoBUS/mensage
add wave -noupdate -color Yellow /MaquinaEstadoBUS/ReadMissForThisBlock
add wave -noupdate -color Yellow /MaquinaEstadoBUS/CPUReadMiss
add wave -noupdate -color Yellow /MaquinaEstadoBUS/WriteMissForThisBlock
add wave -noupdate -color Yellow /MaquinaEstadoBUS/InvalidateForThisBlock
add wave -noupdate -divider Action
add wave -noupdate -color White -subitemconfig {{/MaquinaEstadoBUS/action[1]} {-color White} {/MaquinaEstadoBUS/action[0]} {-color White}} /MaquinaEstadoBUS/action
add wave -noupdate -color Yellow /MaquinaEstadoBUS/WriteBackBlock_AbortMemoryAccess
add wave -noupdate -color Yellow /MaquinaEstadoBUS/EmptyAction
add wave -noupdate -divider <NULL>
add wave -noupdate -color Yellow /MaquinaEstadoBUS/read_miss
add wave -noupdate -color Yellow /MaquinaEstadoBUS/write_miss
add wave -noupdate -color Yellow /MaquinaEstadoBUS/invalidate
add wave -noupdate -divider <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {8 ps} 0}
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
WaveRestoreZoom {0 ps} {154 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 25ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 10 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/MSI 
wave create -driver freeze -pattern clock -initialvalue 0 -period 10ps -dutycycle 50 -starttime 0ps -endtime 100000ps sim:/MaquinaEstadoBUS/clock 
wave create -driver freeze -pattern clock -initialvalue HiZ -period 25ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 10 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/MSI 
WaveExpandAll -1
wave create -driver freeze -pattern clock -initialvalue 0 -period 10ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoBUS/clock 
WaveCollapseAll -1
wave clipboard restore
