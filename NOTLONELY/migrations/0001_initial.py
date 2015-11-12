# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='News',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('title', models.CharField(max_length=20, verbose_name=b'\xe7\xba\xa6\xe6\xa0\x87\xe9\xa2\x98')),
                ('desc', models.TextField(null=True, verbose_name=b'\xe7\xba\xa6\xe7\xae\x80\xe4\xbb\x8b', blank=True)),
                ('meetTime', models.DateTimeField(null=True, verbose_name=b'\xe7\x9b\xb8\xe7\xba\xa6\xe6\x97\xb6\xe9\x97\xb4', blank=True)),
                ('meetPlace', models.CharField(max_length=50, null=True, verbose_name=b'\xe7\x9b\xb8\xe7\xba\xa6\xe5\x9c\xb0\xe7\x82\xb9', blank=True)),
                ('postTime', models.DateTimeField(auto_now_add=True, verbose_name=b'\xe5\x8f\x91\xe5\xb8\x83\xe6\x97\xb6\xe9\x97\xb4')),
                ('personNumberAll', models.IntegerField(verbose_name=b'\xe5\x8f\x82\xe4\xb8\x8e\xe6\x80\xbb\xe4\xba\xba\xe6\x95\xb0')),
                ('personNumberIn', models.IntegerField(verbose_name=b'\xe5\xb7\xb2\xe5\x8f\x82\xe4\xb8\x8e\xe4\xba\xba\xe6\x95\xb0')),
                ('remark', models.CharField(max_length=100, null=True, verbose_name=b'\xe5\xa4\x87\xe6\xb3\xa8', blank=True)),
                ('tag', models.CharField(max_length=100, verbose_name=b'\xe6\xb4\xbb\xe5\x8a\xa8\xe6\xa0\x87\xe7\xad\xbe')),
                ('is_finish', models.BooleanField(default=False, verbose_name=b'\xe6\xb4\xbb\xe5\x8a\xa8\xe6\x98\xaf\xe5\x90\xa6\xe7\xbb\x93\xe6\x9d\x9f')),
            ],
            options={
                'ordering': ['-postTime'],
                'verbose_name': '\u6d88\u606f',
                'verbose_name_plural': '\u6d88\u606f',
            },
        ),
        migrations.CreateModel(
            name='Newspic',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('newsPic', models.ImageField(upload_to=b'newspic/%Y/%m', null=True, verbose_name=b'\xe6\xb6\x88\xe6\x81\xaf\xe7\x85\xa7\xe7\x89\x87', blank=True)),
            ],
            options={
                'verbose_name': '\u6d88\u606f\u7167\u7247',
                'verbose_name_plural': '\u6d88\u606f\u7167\u7247',
            },
        ),
        migrations.CreateModel(
            name='Relation',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('result', models.BooleanField(default=False, verbose_name=b'\xe6\x98\xaf\xe5\x90\xa6\xe5\x90\x8c\xe6\x84\x8f')),
                ('postTime', models.DateTimeField(auto_now_add=True, verbose_name=b'\xe8\xaf\xb7\xe6\xb1\x82\xe6\x97\xb6\xe9\x97\xb4')),
            ],
            options={
                'ordering': ['-postTime'],
                'verbose_name': '\u6d88\u606f\u5173\u7cfb\u7ed3\u679c',
                'verbose_name_plural': '\u6d88\u606f\u5173\u7cfb\u7ed3\u679c',
            },
        ),
        migrations.CreateModel(
            name='Tag',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('tag', models.CharField(max_length=10, null=True, verbose_name=b'\xe4\xb8\xaa\xe4\xba\xba\xe6\xa0\x87\xe7\xad\xbe', blank=True)),
                ('giveRose', models.BooleanField(default=False, verbose_name=b'\xe6\x98\xaf\xe5\x90\xa6\xe9\x80\x81\xe8\x8a\xb1')),
                ('postTime', models.DateTimeField(auto_now_add=True, verbose_name=b'\xe8\xaf\xb7\xe6\xb1\x82\xe6\x97\xb6\xe9\x97\xb4')),
            ],
            options={
                'ordering': ['-postTime'],
                'verbose_name': '\u6807\u7b7e',
                'verbose_name_plural': '\u6807\u7b7e',
            },
        ),
        migrations.CreateModel(
            name='User',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('avatar', models.ImageField(default=b'avatar/default.jpg', upload_to=b'avatar/%Y/%m', max_length=200, blank=True, null=True, verbose_name=b' \xe7\x94\xa8\xe6\x88\xb7\xe5\xa4\xb4\xe5\x83\x8f')),
                ('stu_number', models.CharField(unique=True, max_length=13, verbose_name=b'\xe5\xad\xa6\xe5\x8f\xb7')),
                ('stu_password', models.CharField(max_length=20, verbose_name=b'\xe6\x95\x99\xe5\x8a\xa1\xe7\xb3\xbb\xe7\xbb\x9f\xe5\xaf\x86\xe7\xa0\x81')),
                ('username', models.CharField(unique=True, max_length=10, verbose_name=b'\xe7\x94\xa8\xe6\x88\xb7\xe5\x90\x8d')),
                ('password', models.CharField(max_length=128, verbose_name=b'\xe5\xaf\x86\xe7\xa0\x81')),
                ('nickname', models.CharField(max_length=128, verbose_name=b'\xe6\x98\xb5\xe7\xa7\xb0')),
                ('sex', models.CharField(default=b'female', max_length=10, verbose_name=b'\xe6\x80\xa7\xe5\x88\xab')),
                ('qq', models.CharField(max_length=20, verbose_name=b'QQ\xe5\x8f\xb7\xe7\xa0\x81')),
                ('desc', models.CharField(max_length=200, null=True, verbose_name=b'\xe4\xb8\xaa\xe4\xba\xba\xe7\xae\x80\xe4\xbb\x8b', blank=True)),
                ('rose', models.IntegerField(default=0, verbose_name=b'\xe7\x82\xb9\xe8\xb5\x9e\xe6\x95\xb0')),
                ('tag', models.ManyToManyField(related_name='beCommitted', verbose_name=b'\xe4\xb8\xaa\xe4\xba\xba\xe6\xa0\x87\xe7\xad\xbe', to='NOTLONELY.Tag', blank=True)),
            ],
            options={
                'ordering': ['-id'],
                'verbose_name': '\u7528\u6237',
                'verbose_name_plural': '\u7528\u6237',
            },
        ),
        migrations.AddField(
            model_name='tag',
            name='commitor',
            field=models.ForeignKey(related_name='commitor', verbose_name=b'\xe8\xaf\x84\xe4\xbb\xb7\xe7\x94\xa8\xe6\x88\xb7', to='NOTLONELY.User'),
        ),
        migrations.AddField(
            model_name='tag',
            name='news',
            field=models.ForeignKey(related_name='news_tag', verbose_name=b'\xe6\xb4\xbb\xe5\x8a\xa8', to='NOTLONELY.News'),
        ),
        migrations.AddField(
            model_name='relation',
            name='user',
            field=models.ForeignKey(verbose_name=b'\xe6\xb4\xbb\xe5\x8a\xa8\xe5\x8f\x82\xe4\xb8\x8e\xe8\x80\x85', to='NOTLONELY.User'),
        ),
        migrations.AddField(
            model_name='news',
            name='initiator',
            field=models.ForeignKey(verbose_name=b'\xe5\x8f\x91\xe8\xb5\xb7\xe4\xba\xba', to='NOTLONELY.User'),
        ),
        migrations.AddField(
            model_name='news',
            name='newsPic',
            field=models.ManyToManyField(to='NOTLONELY.Newspic', verbose_name=b'\xe6\xb4\xbb\xe5\x8a\xa8\xe7\x85\xa7\xe7\x89\x87', blank=True),
        ),
        migrations.AddField(
            model_name='news',
            name='relation',
            field=models.ManyToManyField(related_name='news', verbose_name=b'\xe6\xb4\xbb\xe5\x8a\xa8\xe5\x8f\x82\xe4\xb8\x8e\xe5\x85\xb3\xe7\xb3\xbb', to='NOTLONELY.Relation', blank=True),
        ),
    ]
