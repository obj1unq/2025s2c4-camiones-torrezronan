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


	method elDeNivel(nivelDePeligro) = cosas.find({cosa => cosa.nivelPeligrosidad() == nivelDePeligro }) //debe existir alguno del nivel que se busca

	method superaNivel(_nivel) = cosas.filter({cosa => cosa.nivelPeligrosidad() > _nivel})

	method superaElNivelDe(_cosa) = cosas.filter({cosa => cosa.nivelPeligrosidad() > _cosa.nivelPeligrosidad()} )


	method puedeCircularSegunNivel(_nivel) = cosas.any({ cosa => cosa.nivelPeligrosidad()< _nivel  }) && not self.tieneExcesoDePeso()

	method tieneAlgoEntre(min,max) = self.listaDePesos().any({peso => peso > min && peso < max})

	method laCosaMasPesada() = cosas.find({cosa => cosa.peso() == self.pesoDelMasPesado()})
	method pesoDelMasPesado() = cosas.map({ cosa => cosa.peso() }).max()
}
