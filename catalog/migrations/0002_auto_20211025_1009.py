# Generated by Django 3.2.5 on 2021-10-25 15:09

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('catalog', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='maquinaestado',
            name='esp8266',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AddField(
            model_name='maquinaestado',
            name='password',
            field=models.CharField(max_length=20, null=True),
        ),
        migrations.AddField(
            model_name='maquinaestado',
            name='red',
            field=models.CharField(max_length=20, null=True),
        ),
    ]
