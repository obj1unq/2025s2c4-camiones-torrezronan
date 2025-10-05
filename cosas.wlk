object knightRider {
	method peso() { return 500 }
	method nivelPeligrosidad() { return 10 }
}


object arenaGranel {
	var property peso = 1
	method nivelPeligrosidad() = 1

}

object bumblebee {
	method peso() = 800

	var property estado =  1 //Si es auto el estado es 1, si es robot el estado es 0

	method nivelPeligrosidad() = if(self.esAuto())30 else 15
	
	method esAuto()= estado == 1
}



object ladrillos {
	const pesoPorLadrillo = 2

	var property cantidadDeLadrillos = 0

	method peso() = pesoPorLadrillo * cantidadDeLadrillos
	method nivelPeligrosidad() =  2
}


object bateriaAntiAerea {
	method peso() = if(self.estaConMisiles()) 300 else 200

	var property estado =  1 //Si esta con misiles el estado es 1 de lo contrario es 0

	method nivelPeligrosidad() = if(self.estaConMisiles()) 100 else 0
	
	method estaConMisiles()= estado == 1
}

object residuosRadiactivos {
	var property peso = 0
	method nivelPeligrosidad() =  200
}