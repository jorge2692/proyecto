from django.db import models
from django.db.models.fields import CharField
from django.urls import reverse #Used to generate URLs by reversing the URL patterns
import uuid # Requerida para las instancias de libros únicos


# Create your models here.

class Tipo(models.Model):
    """
    Modelo que representa el tipo de equipo a manejar.
    """
    name = models.CharField(max_length=20, help_text="Ingrese el tipo de equipo:")

    def __str__(self):
        """
        Cadena que representa a la instancia particular del modelo (p. ej. en el sitio de Administración)
        """
        return self.name


class Maquina(models.Model):

    modelo = models.CharField(max_length=20)

    voltaje = models.CharField(max_length=4)

    amperios = models.CharField(max_length=4)

    numequipo = models.CharField(max_length=20)

    fabricante = models.CharField(max_length=20)

    edificio = models.ForeignKey('Edificio', on_delete=models.SET_NULL, null=True)
    # ForeignKey, ya que una maquina un solo edificio

    descripcion = models.TextField(max_length=1000, help_text="Ingrese una breve descripción del equipo")

    serial = models.CharField('Serial',max_length=13, help_text='Serial del equipo')

    tipo = models.ManyToManyField(Tipo, help_text="Seleccione un tipo de equipo")

    def __str__(self):
       
        return self.modelo


    def get_absolute_url(self):
        
        return reverse('Detalles del equipo', args=[str(self.id)])


    def display_tipo(self):
        """
        Creates a string for the Genre. This is required to display genre in Admin.
        """
        return ', '.join([ Tipo.name for Tipo in self.tipo.all()[:3] ])
    display_tipo.short_description = 'Tipo'



class MaquinaEstado(models.Model):
   
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, help_text="ID único para este equipo en particular.")
    
    esp8266 = models.CharField(max_length=20, null=True)

    red = models.CharField(max_length=20, null=True)

    password = models.CharField(max_length=20, null= True)

    maquina = models.ForeignKey('Maquina', on_delete=models.SET_NULL, null=True)

    LOAN_STATUS = (
        ('m', 'Maintenance'),
        ('o', 'On loan'),
        ('a', 'Available'),
    )

    estado = models.CharField(max_length=1, choices=LOAN_STATUS, blank=True, default='m', help_text='Disponibilidad del equipo')

    class Meta:
        ordering = ["id"]


    def __str__(self):
       
        return '%s (%s)' % (self.id,self.maquina.modelo)


class Edificio(models.Model):
    """
    Modelo que representa un edificio
    """
    nombre = models.CharField(max_length=100)
    direccion = models.CharField(max_length=100)
    puesta_marcha = models.DateField(null=True, blank=True)

    def get_absolute_url(self):

        return reverse('Detalles Edificio', args=[str(self.id)])


    def __str__(self):
        
        return '%s, %s' % (self.direccion, self.nombre)
