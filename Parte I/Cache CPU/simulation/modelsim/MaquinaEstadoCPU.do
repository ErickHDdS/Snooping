onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /MaquinaEstadoCPU/clock
add wave -noupdate -color {Orange Red} /MaquinaEstadoCPU/MSI
add wave -noupdate -divider State
add wave -noupdate -color Cyan -subitemconfig {{/MaquinaEstadoCPU/newState[1]} {-color Cyan -height 15} {/MaquinaEstadoCPU/newState[0]} {-color Cyan -height 15}} /MaquinaEstadoCPU/newState
add wave -noupdate -color Magenta -subitemconfig {{/MaquinaEstadoCPU/state[1]} {-color Magenta -height 15} {/MaquinaEstadoCPU/state[0]} {-color Magenta -height 15}} /MaquinaEstadoCPU/state
add wave -noupdate -color Yellow /MaquinaEstadoCPU/invalid
add wave -noupdate -color Yellow /MaquinaEstadoCPU/exclusive
add wave -noupdate -color Yellow /MaquinaEstadoCPU/shared
add wave -noupdate -divider Message
add wave -noupdate -color Red -subitemconfig {{/MaquinaEstadoCPU/mensage[1]} {-color Red -height 15} {/MaquinaEstadoCPU/mensage[0]} {-color Red -height 15}} /MaquinaEstadoCPU/mensage
add wave -noupdate -color Yellow /MaquinaEstadoCPU/PlaceReadMissOnBus
add wave -noupdate -color Yellow /MaquinaEstadoCPU/PlaceWriteMissOnBus
add wave -noupdate -color Yellow /MaquinaEstadoCPU/PlaceInvalidateOnBus
add wave -noupdate -color Yellow /MaquinaEstadoCPU/EmptyMessage
add wave -noupdate -divider Action
add wave -noupdate -color White -subitemconfig {{/MaquinaEstadoCPU/action[1]} {-color White -height 15} {/MaquinaEstadoCPU/action[0]} {-color White -height 15}} /MaquinaEstadoCPU/action
add wave -noupdate -color Yellow /MaquinaEstadoCPU/WriteBackBlock
add wave -noupdate -color Yellow /MaquinaEstadoCPU/WriteBackCacheBlock
add wave -noupdate -color Yellow /MaquinaEstadoCPU/EmptyAction
add wave -noupdate -divider <NULL>
add wave -noupdate -color Yellow /MaquinaEstadoCPU/read_miss
add wave -noupdate -color Yellow /MaquinaEstadoCPU/write_miss
add wave -noupdate -color Yellow /MaquinaEstadoCPU/read_hit
add wave -noupdate -color Yellow /MaquinaEstadoCPU/write_hit
add wave -noupdate -divider <NULL>
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 194
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
WaveRestoreZoom {0 ps} {964 ps}
view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 50ps -dutycycle 50 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoCPU/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 11 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 10000ps sim:/MaquinaEstadoCPU/MSI 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
