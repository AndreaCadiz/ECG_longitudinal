#### importe con el paquete RHVH ----

library(RHRV)

hrv.data <- CreateHRVData()

hrv.data <- LoadBeatWFDB(hrv.data, RecordName = "ECGPCG0003",annotator = "dat")
# hrv.data$Beat$Time: vector con los tiempos (en segundos) de cada latido detectado.

# # Calcular HRV paso a paso
# hrv.data <- BuildNIHR(hrv.data)
# hrv.data <- FilterNIHR(hrv.data)
# hrv.data <- InterpolateNIHR(hrv.data)
# hrv.data <- CreateTimeAnalysis(hrv.data)
# 
# 
# # Extraer intervalos RR
# RR_intervals <- diff(hrv.data$Beat$Time)
# hist(RR_intervals, main = "Intervalos RR", xlab = "Segundos")
# 
# # Visualizar los intervalos normales entre latidos (NIHR)
# PlotNIHR(hrv.data)


# # Extraer tiempos de los latidos
# r_peak_times <- hrv.data$Beat$Time
# 
# # Interpolar para encontrar las amplitudes en esos tiempos (opcional)
# # Si tienes ecg_mV y time, puedes encontrar índice más cercano
# r_peak_indices <- sapply(r_peak_times, function(t) which.min(abs(time - t)))


#### importe con R basico -----

# Parámetros desde el .hea
record_name <- "ECGPCG0003"
n_signals <- 2
fs <- 8000               # Frecuencia de muestreo
n_samples <- 240000      # Total de muestras

# Abrir archivo .dat
file_conn <- file(paste0(record_name, ".dat"), "rb")

# Leer los datos binarios como enteros de 16 bits
raw_data <- readBin(file_conn, what = "integer", size = 2, signed = TRUE, endian = "little", n = n_samples * n_signals)

close(file_conn)

# Convertir a matriz (cada columna es una señal)
data_matrix <- matrix(raw_data, ncol = n_signals, byrow = TRUE)

# Vector de tiempo
time <- seq(0, (n_samples - 1)) / fs

# Extraer señales
ecg_raw <- data_matrix[,1]
pcg_raw <- data_matrix[,2]

# Aplicar ganancias y desplazamientos (desde .hea)
ecg_mV <- (ecg_raw - (-14265)) / 110554.8863  # Señal ECG en mV
pcg_mV <- (pcg_raw - 6207) / 54162.0791       # Señal PCG en mV

# Graficar ECG
plot(time, ecg_mV, type = "l", xlab = "Tiempo (s)", ylab = "ECG (mV)", main = "ECG")
