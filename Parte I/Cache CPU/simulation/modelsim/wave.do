view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 50ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/MaquinaEstadoCPU/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 11 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 1000ps sim:/MaquinaEstadoCPU/MSI 
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 1000ps sim:/MaquinaEstadoCPU/clock 
wave create -driver freeze -pattern counter -startvalue 00 -endvalue 11 -type Range -direction Up -period 50ps -step 1 -repeat forever -range 1 0 -starttime 0ps -endtime 1000ps sim:/MaquinaEstadoCPU/MSI 
WaveExpandAll -1
WaveCollapseAll -1
wave clipboard restore
