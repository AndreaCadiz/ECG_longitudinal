##### con el paquete RHVH ----
beats <- hrv.data$Beat$Time
head(beats)

#### pracma -----


# ecg_mV : vector con la señal ECG en milivoltios
# time   : vector con el tiempo correspondiente (en segundos)

library(pracma)
# Detectar picos R 
#minpeakheigt: Si los picos R llegan a 1.0 mV, puedes probar minpeakheight = 0.3 (unos 30% del valor máximo).
            #  Si tu señal es débil (picos de 0.5 mV), prueba con minpeakheight = 0.15.
max(ecg_mV)


#minpeakdistance: Si trabajas con señal a 8000 Hz, prueba: minpeakdistance = 4800 =(0.6*8000), 0.6s entre pitidos
               #  Si la señal es 250Hz prueba con 150

# npeaks: Sabemos con beats cuantos R hay.

peaks <- findpeaks(ecg_mV, minpeakheight = 0.15, npeaks=length(beats))

# Extraer índices de los picos R detectados
r_peak_indices <- peaks[,2]

# Obtener los tiempos de esos picos
r_peak_times <- time[r_peak_indices]
