# Generated by Django 3.0.4 on 2023-01-13 00:15

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('customBuildings', '0004_buildingdmgvun_date'),
    ]

    operations = [
        migrations.AddField(
            model_name='attributetype',
            name='name',
            field=models.CharField(default='damage', max_length=20),
            preserve_default=False,
        ),
    ]
