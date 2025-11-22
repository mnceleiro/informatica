function calcularAreaTriangulo(base, altura) {
  let area = base * altura;

  return area;
}

let area1 = calcularAreaTriangulo(10, 15);
let area2 = calcularAreaTriangulo(2, 5);

document.write("El área del triángulo de base " + base + " y altura " + altura + " es: " + area1);
document.write("El área obtenida de multiplicar la base " + base + " por la altura " + altura + " es: " + area2);
