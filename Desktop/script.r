ventas <- data.frame(
  MESES = c("Enero","Febrero","Marzo","Abril","Mayo"),
  VALORES = c(72,84,91,NA,85)
)
write.csv(ventas,"ventas.csv",row.names = FALSE)

install.packages("magrittr")
install.packages("ggplot2")
install.packages("munsell") 
install.packages("labeling")
library(ggplot2)


datos <- read.csv("ventas.csv")

ggplot(datos, aes(x = MESES, y = VALORES)) +
  geom_bar(stat = "identity", fill = "red", color = "black") +
  theme_minimal() +
  labs(title = "Ventas Mensuales", x = "Meses", y = "Valores")

print(datos)

