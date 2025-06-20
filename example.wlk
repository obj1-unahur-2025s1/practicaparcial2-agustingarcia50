class Raza {
    var property rol
    const property  fuerza
    const inteligencia

    method potencialOfensivo(){
        return fuerza * 10 + rol.extra()
    }

    method esGroso()= self.esInteligente() || rol.esGroso(self)
    method esInteligente()


}

class Humano inherits Raza{
   override method esInteligente()= inteligencia > 50
}

class Orco inherits Raza{
    override method potencialOfensivo()= super() *1.1 
}

class Cazador  {
    const Mascota
    method extra()= Mascota.potencialOfensivo() 
    method esGroso(unPersonaje)= Mascota.esLongeva()
}
object guerrero {
    method extra() = 100
    method esGroso(unPersonaje)= unPersonaje.fuerza() >50
}

object brujo {
    method esGroso(unPersonaje)= true 
}
class Mascota {
    const property fuerza
    var edad 
    const property  garras

    method cumplirAños(){edad+=1}
    method potencialOfensivo() = if(garras) fuerza*2 else fuerza
    method esLongeva() = edad < 10
}

object noTieneMascota {
    method potencialOfensivo() = 0
     method esLongeva() = false
}


class Localidad {
    var ejercito
    method poderDefensivo()= ejercito.poderOfensivo()
    method serOcupada(unEjercito)

}
class Aldea inherits Localidad{
  const maxTropa
  method initialize(){
    if (maxTropa<10){
      self.error("La poblacion debe ser mayor a 10")
    }
  }
   override method serOcupada(unEjercito){
        if(maxTropa<unEjercito.tamaño()){
            ejercito = new Ejercito (tropa= unEjercito.losMasPoderosos())
            unEjercito.quitarLosMasFuertes()
        }
        else {ejercito = unEjercito}
    }


}

class Ciudad inherits Localidad {
     override method poderDefensivo() = super() +300
     override method  serOcupada(unEjercito){ejercito = unEjercito}

}


class Ejercito {
  const tropa= []
  method poderOfensivo()= tropa.sum{p=>p.potencialOfensivo()}
  method invadir(unaLocalidad){
      if (self.puedeInvadir(unaLocalidad)){
          unaLocalidad.serOcupada(self)
      }
  }
  method puedeInvadir(unaLocalidad){
      return self.poderOfensivo()> unaLocalidad.poderDefensivo()
  }
  method losMasPoderosos()= self.ordenadosMasPoderosos().take(10)
  method ordenadosMasPoderosos()= tropa.sortBy({t1,t2=> t1.potencialOfensivo()> t2.potencialOfensivo()})
  method tamaño() = tropa.size()
  method quitarLosMasFuertes(){
    tropa.removeAll(self.losMasPoderosos())
  }
}
