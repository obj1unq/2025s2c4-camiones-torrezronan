import cosas.*

object camion {
	const property cosas = #{}

	const pesoTara = 1000
	const pesoMaximosSoportado = 2500

	method listaDePesos() = cosas.map({cosa => cosa.peso() })

	method listaDeNivelesDePeligro() = cosas.map({cosa => cosa.nivelPeligrosidad() }) 
		
	method cargar(unaCosa) {
		if(not cosas.contains(unaCosa)) cosas.add(unaCosa) else cosas.add({})
	}

	method descargar(unaCosa) {
		if(cosas.contains(unaCosa)) cosas.remove(unaCosa) else cosas.remove({})
	}

	method todosSonPares() = self.listaDePesos().all({peso => peso % 2 == 0})

	method hayAlgoQuePese(_peso) = self.listaDePesos().any({ pesoCosa => pesoCosa == _peso })

	method pesoTotal() = pesoTara + self.listaDePesos().sum()

	method tieneExcesoDePeso() = self.pesoTotal() > pesoMaximosSoportado


	method elDeNivel(nivelDePeligro) = cosas.find({cosa => cosa.nivelPeligrosidad() == nivelDePeligro }) //debe existir alguno del nivel que se busca o se puede usar filter y devuelve una coleccion vacia

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

		if( self.elCaminoSoportaElViaje(camino) ) 
			self.descargarYVaciarCamionEn(destino)
			
		else return"no se puede transportar"
	}

	method elCaminoSoportaElViaje(tipoCamino)  {
		if(tipoCamino.restriccionesDeTipo() == "restricciones De Nivel") {return self.puedeCircularSegunNivel(tipoCamino.circulaHastaNivel())} 
			else  {return self.puedeCircularSegunPesoPorCamino(tipoCamino)  }  
	}

	method puedeCircularSegunPesoPorCamino(_tipoCamino) = (self.pesoTotal() < _tipoCamino.circulaHastaPeso()) && not self.tieneExcesoDePeso()

	method vaciarCamion() { cosas.clear() }

	method descargarYVaciarCamionEn(_destino) {
		_destino.descargarCamion(cosas)
		self.vaciarCamion()
	}
}


object almacen {
	const property bodega = #{}
	
	method descargarCamion(_cosas) {
		bodega.addAll(_cosas)
	} 
}


object rutaNueve {
	
	
	const property circulaHastaNivel = 20
	method restriccionesDeTipo() = "restricciones De Nivel" 
}

object rutaVecinal{
	var property circulaHastaPeso = 0
	method restriccionesDeTipo() = "restricciones De Peso"
}
