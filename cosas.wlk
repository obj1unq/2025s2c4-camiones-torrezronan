object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
	method bultosQueOcupa() = 1
	method chocamos() {
		
	}
}


object arenaGranel {
	var property peso = 1
	method nivelPeligrosidad() = 1
	method bultosQueOcupa() = 1

	method chocamos() {
		peso = peso + 20
	}

}

object bumblebee {
	method peso() = 800

	var property estado =  1 //Si es auto el estado es 1, si es robot el estado es 0

	method nivelPeligrosidad() = if(self.esAuto())30 else 15
	
	method esAuto()= estado == 1

	method bultosQueOcupa() = 2

	method chocamos() {
		estado = if(estado== 1){0} else {1}
	}
}



object ladrillos {
	const pesoPorLadrillo = 2

	var property cantidadDeLadrillos = 0

	method peso() = pesoPorLadrillo * cantidadDeLadrillos
	method nivelPeligrosidad() =  2

	method bultosQueOcupa() = if( cantidadDeLadrillos<=100 ) {1} else if(cantidadDeLadrillos > 100 && cantidadDeLadrillos<=300) {2} else {3}

	method chocamos() {
		cantidadDeLadrillos = if(cantidadDeLadrillos >=12){cantidadDeLadrillos - 12} else {0}
	}
}


object bateriaAntiAerea {
	method peso() = if(self.estaConMisiles()) 300 else 200

	var property estado =  1 //Si esta con misiles el estado es 1 de lo contrario es 0 esta descargado

	method nivelPeligrosidad() = if(self.estaConMisiles()) 100 else 0
	
	method estaConMisiles()= estado == 1

	method bultosQueOcupa() = if(self.estaConMisiles()){2} else 1

	method chocamos() {
		self.estado(0)
	}
}

object residuosRadiactivos {
	var property peso = 0
	method nivelPeligrosidad() =  200
	method bultosQueOcupa() = 1

	method chocamos() {
		peso = peso + 15
	}
}


object contenedorPortuario {

	var property contenido = #{}

	const pesoVacio = 100

	method peso() = contenido.map({cosa => cosa.peso() }).sum() + pesoVacio 

	method ponerDentro(cosa){contenido.add(cosa) }

	method nivelPeligrosidad() = if(contenido.isEmpty()) 0 else contenido.map({cosa => cosa.nivelPeligrosidad()}).max()

	method bultosQueOcupa() = 1 + contenido.map({cosa => cosa.bultosQueOcupa() }).sum()

	method chocamos() {
		contenido.forEach({cosa => cosa.chocamos() })
	}
  
}


object embalaje {
	var property envuelve = 0
	method peso() = envuelve.peso()
	method nivelPeligrosidad() = envuelve.nivelPeligrosidad()/2
	method bultosQueOcupa() = 2
	method chocamos() {
	  
	}
}

