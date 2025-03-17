# ecg_mV : vector con la señal ECG en milivoltios
# time   : vector con el tiempo correspondiente (en segundos)

library(pracma)
# Detectar picos R (ajusta minpeakheight a tu señal)
peaks <- findpeaks(ecg_mV, minpeakheight = 0.3, minpeakdistance = 200)

# Extraer índices de los picos R detectados
r_peak_indices <- peaks[,2]

# Obtener los tiempos de esos picos
r_peak_times <- time[r_peak_indices]
