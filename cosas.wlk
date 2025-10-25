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

	var property estado =  auto //Si es auto el estado es 1, si es robot el estado es 0 en este caso es auto hasta que se lo cambie

	method nivelPeligrosidad() = estado.nivelDePeligro()
	
	method bultosQueOcupa() = 2

	method chocamos() {
		estado.chocar(self)
	}

}

object auto {
	const property nivelDePeligro = 15
	method chocar(autobot) {
		autobot.estado(robot)
	}
}

object robot {
	const property nivelDePeligro = 30
	method chocar(autobot) {
		autobot.estado(self)

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

	var property estado = true // true sin tiene misiles y false si no los tiene
	

	method nivelPeligrosidad() = if(self.estaConMisiles()) 100 else 0
	
	method estaConMisiles() = self.estado()

	method bultosQueOcupa() = if(self.estaConMisiles()){2} else 1

	method chocamos() {
		self.estado(false)
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

