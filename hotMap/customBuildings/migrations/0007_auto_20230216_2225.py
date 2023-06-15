# Generated by Django 3.0.4 on 2023-02-17 02:25

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion
import django.utils.timezone


class Migration(migrations.Migration):

    dependencies = [
        ('customBuildings', '0006_auto_20230216_2029'),
    ]

    operations = [
        migrations.AddField(
            model_name='buildingdmgvun',
            name='added_by',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.CASCADE, related_name='added_damageVunerabilities', to=settings.AUTH_USER_MODEL),
        ),
        migrations.AddField(
            model_name='buildingdmgvun',
            name='added_date',
            field=models.DateField(auto_now_add=True, default=django.utils.timezone.now),
            preserve_default=False,
        ),
    ]