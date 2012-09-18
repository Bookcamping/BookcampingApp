# encoding: utf-8
class AddLibraryInfo < ActiveRecord::Migration
  def change
    add_column :libraries, :logo, :string, limit: 50
    add_column :libraries, :slogan, :string, limit: 300
    add_column :libraries, :question, :string, limit: 200

    Library.reset_column_information

    b = Library.find 1
    b.description = "Hola, bienvenida a bookcamping\nbookcamping es una biblioteca abierta y colaborativa que nace a la luz del 15M cuyo objetivo es socializar la lectura e incentivar la cultura del compartir.\nAquí se puede reseñar, enlazar y descargar contenidos en diversos formatos (textos, audios, videos). Lejos de querer ser un ’libros yonkis’ #bookcamping propone llenar sus estanterías con contenido 100% libre contribuyendo a un modelo de cultura sostenible"
    b.logo = 'bookcamping.png'
    b.slogan = 'Algunos libros para entender cómo hemos llegado hasta aquí (poque no salimos de la nada)'
    b.question = '¿Y tú, qué libro te llevarías a tu plaza/acampada/bookcamping?'
    b.save

    b = Library.find 2
    b.description = "Hola, bienvenida a videocamping\nvideocamping es una videoteca abierta y colaborativa que nace a la luz del 15M"
    b.logo = 'videocamping.png'
    b.slogan = 'Algunos vídeos para entender cómo hemos llegado hasta aquí (poque no salimos de la nada)'
    b.question = '¿Y tú, qué vídeo te llevarías a tu plaza/acampada/bookcamping?'
    b.save

    b = Library.find 6
    b.description = 'Este es el lugar para compartir y descubrir'
    b.logo = 'nologo.png'
    b.slogan = 'Algunas referencias para entender cómo seguimos a partir de ahora'
    b.question = '¿Y tu, qué llevarías a tu próxima plaza/acampada/bookcamping?'
    b.save
  end
end
