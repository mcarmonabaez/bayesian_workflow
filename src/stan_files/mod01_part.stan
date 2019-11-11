
// Muestrear la distribución inicial
data {
  int k; // Número de estratos
  int N; // Número de casillas
  int votantes_nom[N]; // Lista nominal por casilla
  int est[N]; // Identificador del estrato
}

parameters {

}

// muestrear la distribución inicial
generated quantities {
  
  // Simular configuraciones del modelo a partir de modelo inicial
  
  int y[N]; // casillas
  real<lower=0, upper=1> part_est[k]; // participación por estrato
  real<lower=0, upper =1> prop; // proporción de votantes
  real<lower=0, upper = 1> part; // participación geneal
  real<lower=0> phi_total; // parámetro de dispersión
  
  // distribución de la participación general
  part = beta_rng(6, 6);
  phi_total = fabs(normal_rng(0, 0.15));
  
  // participación por estrato
  for(j in 1:k){
    part_est[j] = beta_rng(part, 1.0 / phi_total);
  }
  
  // Simular comportamiento de la casillas
  for(i in 1:N){
    y[i] = binomial_rng(votantes_nom[i], part_est[est[i]]);
  }
  
  // Proporción de votantes
  prop = sum(y) / (sum(votantes_nom) + 0.0);
}
