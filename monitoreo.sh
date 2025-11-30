# tarea3_monitoreo
#!/bin/bash

echo "Tiempo(s)  CPU_Libre(%)  Mem_Libre(%)  Disco_Libre(%)" > registro.txt

for t in 60 120 180 240 300
do
    CPU=$(top -b -n 1 | grep "Cpu(s)" | awk '{print $8}')
    
    MEM_TOTAL=$(free -m | grep Mem: | awk '{print $2}')
    MEM_LIBRE=$(free -m | grep Mem: | awk '{print $4}')
    MEM_PORC=$(echo "scale=2; ($MEM_LIBRE/$MEM_TOTAL)*100" | bc)

    DISCO_USO=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
    DISCO_LIBRE=$(echo "100 - $DISCO_USO" | bc)

    echo "$t    $CPU    $MEM_PORC    $DISCO_LIBRE" >> registro.txt

    sleep 60
done
