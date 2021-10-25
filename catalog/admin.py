from django.contrib import admin
from .models import Edificio, Tipo, Maquina, MaquinaEstado


# Register your models here.

# admin.site.register(Maquina)
# admin.site.register(Edificio)
admin.site.register(Tipo)
# admin.site.register(MaquinaEstado)

class EdificioAdmin(admin.ModelAdmin):
    list_display = ('nombre', 'direccion', 'puesta_marcha')
    fields = ['nombre', 'direccion', ('puesta_marcha')]

# Register the admin class with the associated model
admin.site.register(Edificio, EdificioAdmin)


@admin.register(Maquina)
class MaquinaAdmin(admin.ModelAdmin):
    list_display = ('modelo', 'edificio', 'display_tipo')

# Register the Admin classes for BookInstance using the decorator

@admin.register(MaquinaEstado)
class BookInstanceAdmin(admin.ModelAdmin):
    list_display = ('id', 'maquina', 'estado', 'esp8266')
    list_filter = ('estado', 'esp8266')

