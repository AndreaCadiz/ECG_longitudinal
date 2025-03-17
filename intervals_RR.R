RRbeats<-diff(beats)

RRpeaks_times <- diff(r_peak_times)

hist(RRbeats)
hist(RRpeaks_times)

# Intervalos RR normales suelen estar entre 0.6 – 1.2 segundos (en reposo).
# RR muy bajos → frecuencia alta (taquicardia).
# RR muy altos → frecuencia baja (bradicardia).

plot(RRbeats,type="l")
plot(RRpeaks_times,type="l")


### deteccions de outliers ----

## metodo robusto de los percentiles
q_low <- quantile(RRbeats, 0.025)
q_high <- quantile(RRbeats, 0.975)
anomalies_percentile <- which(RRbeats < q_low | RRbeats > q_high)

# Mostrar valores anómalos
RRbeats[anomalies_percentile]

plot(RRbeats, type = "l", main = "Intervalos RR con Anómalos", ylab = "RR (s)", xlab = "Latido #")
points(anomalies_percentile, RRbeats[anomalies_percentile], col = "red", pch = 20)


## +-2 sd
# en este caso no lo usamos porque como los valores anomolos son tan altos 50-90
# y la mediana es 0.13 la sd queda muy desajustada