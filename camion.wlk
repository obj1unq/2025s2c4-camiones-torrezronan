import cosas.*

object camion {
	const property cosas = #{}

	const pesoTara = 1000
	const pesoMaximosSoportado = 2500

	method listaDePesos() = cosas.map({cosa => cosa.peso() })

	method listaDeNivelesDePeligro() = cosas.map({cosa => cosa.nivelPeligrosidad() }) 
		
	method cargar(unaCosa) { 
		self.validarSiPuedeCargarUnaCosa(unaCosa)
		cosas.add(unaCosa)
	}

	method validarSiPuedeCargarUnaCosa(cosa) = if(self.contieneUnacosa(cosa)) self.error("No se puede cargar, el objeto ya esta en el camion")

	method contieneUnacosa(unaCosa) = cosas.contains(unaCosa)	

	method descargar(unaCosa) {
		self.validarSiPuedeDescargarUnaCosa(unaCosa)
		cosas.remove(unaCosa)
	}

	method validarSiPuedeDescargarUnaCosa(cosa) = if(not self.contieneUnacosa(cosa))self.error("No se puede descargar, el objeto no esta cargado")

	method todosSonPares() = self.listaDePesos().all({peso => peso % 2 == 0})

	method hayAlgoQuePese(_peso) = self.listaDePesos().any({ pesoCosa => pesoCosa == _peso })

	method pesoTotal() = pesoTara + self.listaDePesos().sum()

	method tieneExcesoDePeso() = self.pesoTotal() > pesoMaximosSoportado


	method elDeNivel(nivelDePeligro) = cosas.find({cosa => cosa.nivelPeligrosidad() == nivelDePeligro }) 

	method superaNivel(_nivel) = cosas.filter({cosa => cosa.nivelPeligrosidad() > _nivel})

	method superaElNivelDe(_cosa) = cosas.filter({cosa => cosa.nivelPeligrosidad() > _cosa.nivelPeligrosidad()} )


	method puedeCircularSegunNivel(_nivel) =  not self.tieneExcesoDePeligrosidad(_nivel) && not self.tieneExcesoDePeso()

	method tieneExcesoDePeligrosidad(nivel) = cosas.any({ cosa =>  cosa.nivelPeligrosidad() > nivel  })	 

	method tieneAlgoEntre(min,max) = self.listaDePesos().any({peso => peso > min && peso < max})

	method laCosaMasPesada() = cosas.find({cosa => cosa.peso() == self.pesoDelMasPesado()})

	method pesoDelMasPesado() = cosas.map({ cosa => cosa.peso() }).max()

	method cantidadDeBultos() = cosas.map({cosa => cosa.bultosQueOcupa() }).sum()

	method choco() {
		cosas.forEach({cosa => cosa.chocamos() })
	}


	method transportar(destino,camino) {

		self.validarCaminoSoporta(camino)
		self.descargarYVaciarCamionEn(destino)				
	}

	method validarCaminoSoporta(tipoCamino) = if(not self.elCaminoSoportaElViaje(tipoCamino)){self.error("El camino no soporta este camion")}

	method elCaminoSoportaElViaje(tipoCamino)  {
		return tipoCamino.puedeCircularEnEstaRuta(self)  
	}

	method puedeCircularSegunPeso(pesoMaximo) = (self.pesoTotal() < pesoMaximo) && not self.tieneExcesoDePeso()

	method vaciarCamion() { cosas.clear() }

	method descargarYVaciarCamionEn(destino) {
		destino.descargarCamion(cosas)
		self.vaciarCamion()
	}


	
}

class MyException inherits wollok.lang.Exception {}



object almacen {
	const property bodega = #{}
	
	method descargarCamion(_cosas) {
		bodega.addAll(_cosas)
	} 
}


object rutaNueve {
	
	const property peligrosidadMaxima = 20
	
	method puedeCircularEnEstaRuta(vehiculo) =  vehiculo.puedeCircularSegunNivel(peligrosidadMaxima) 
}

object rutaVecinal{
	
	var property pesoMaximo = 0
	
	method puedeCircularEnEstaRuta(vehiculo) = vehiculo.puedeCircularSegunPeso(pesoMaximo)
}
