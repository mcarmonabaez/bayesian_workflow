
data {
  int k; // num_estratos
  int N; // num casillas total
  int n; // num casillas muestra
  int votantes_nom[N]; // lista nominal para cada casilla
  int votantes_nom_muestra[n];
  int est[N]; // indicador de estrato para cada casilla
  int est_muestra[n]; 
  int y[n]; // observaciones
}

// The parameters accepted by the model. 
parameters {
  real<lower=0, upper = 1> part;
  real<lower=0> phi_total;
  real<lower=0, upper=1> part_est[k];
}

model {
  part ~ beta(6, 3);
  phi_total ~ normal(0, 0.15) T[0,];
  for(j in 1:k){
    part_est[j] ~ beta_proportion(part, 1.0 / phi_total);
  }  
  for(i in 1:n){
    y[i] ~ binomial(votantes_nom_muestra[i], part_est[est_muestra[i]]);
  }

}

generated quantities {
  real y_sim[n];

  for (i in 1:n){
    y_sim[i] = binomial_rng(votantes_nom_muestra[i], part_est[est_muestra[i]]);
  }
    
}