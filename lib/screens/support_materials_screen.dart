// lib/screens/support_materials_screen.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'material_item.dart';

final List<MaterialItem> materials = [
  MaterialItem(
    title: 'Diccionario Visual de Lengua de Señas Internacional',
    description: 'Diccionario PDF con señas usadas internacionalmente.',
    type: 'pdf',
    url: 'https://pdh.cdmx.gob.mx/storage/app/media/banner/Dic_LSM%202.pdf',
  ),
  MaterialItem(
    title: 'Curso de Lengua de Señas Americana (ASL) en YouTube',
    description: 'Playlist en YouTube para aprender ASL.',
    type: 'video',
    url: 'https://www.youtube.com/watch?v=btlFQxyHQqA',
  ),
  MaterialItem(
    title: 'Manual de Accesibilidad en la Comunicación - ONU',
    description: 'Manual de accesibilidad en la comunicación por la ONU.',
    type: 'pdf',
    url: 'https://www.un.org/sites/un2.un.org/files/2204195_s_undis_communication_guidelines.pdf',
  ),
  MaterialItem(
    title: 'Plataforma de Cursos sobre Lengua de Señas - Coursera',
    description: 'Cursos gratuitos y pagos en Coursera sobre lengua de señas.',
    type: 'link',
    url: 'https://www.minedu.gob.pe/superiorpedagogica/producto/curso-lengua-de-senas-peruana-nivel-basico/',
  ),
  MaterialItem(
    title: 'Guía de Comunicación Inclusiva - UNESCO',
    description: 'PDF con directrices de comunicación inclusiva por UNESCO.',
    type: 'pdf',
    url: 'https://www.oas.org/es/cim/docs/GuiaComunicacionInclusivaOEA-ES.pdf',
  ),
  MaterialItem(
    title: 'Curso Completo de Lengua de Señas Española (LSE)',
    description: 'Curso en YouTube sobre la Lengua de Señas Española.',
    type: 'video',
    url: 'https://www.youtube.com/watch?app=desktop&v=bVqC_EvOLaI',
  ),
  MaterialItem(
    title: 'Diccionario de Lengua de Señas Mexicana',
    description: 'Diccionario de señas mexicanas en PDF.',
    type: 'pdf',
    url: 'https://www.conapred.org.mx/documentos_cedoc/Diccionario_Lengua_Senas.pdf',
  ),
  MaterialItem(
    title: 'Curso de Lengua de Señas Brasileña (Libras)',
    description: 'Curso introductorio en video sobre Libras.',
    type: 'video',
    url: 'https://www.youtube.com/playlist?list=PLFf5ABqvx6knv8tKLbbnNC1TTcfwPVXK1',
  ),
  MaterialItem(
    title: 'Aplicación Móvil de Lengua de Señas',
    description: 'Artículo con las mejores aplicaciones móviles para aprender lengua de señas.',
    type: 'link',
    url: 'https://www.lifewire.com/best-apps-to-learn-sign-language-4176268',
  ),
  MaterialItem(
    title: 'Libro de Accesibilidad y Comunicación Alternativa - UNICEF',
    description: 'Manual de UNICEF para accesibilidad y comunicación alternativa.',
    type: 'pdf',
    url: 'https://www.unicef.org/documents/accessible-communication-handbook',
  ),
];

class SupportMaterialsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materiales de Apoyo'),
        backgroundColor: Colors.blue[800],
      ),
      body: ListView.builder(
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final material = materials[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: Icon(
                _getIcon(material.type),
                color: Colors.blue,
              ),
              title: Text(material.title),
              subtitle: Text(material.description),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _launchURL(material.url),
            ),
          );
        },
      ),
    );
  }

  IconData _getIcon(String type) {
    switch (type) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'video':
        return Icons.video_library;
      case 'link':
        return Icons.link;
      default:
        return Icons.description;
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
