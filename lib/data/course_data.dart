class CourseData {
  // Colección tipada: cada curso se representa mediante un mapa.
  static final List<Map<String, dynamic>> courses = [
    {
      'nombre': 'Desarrollo móvil con Flutter',
      'docente': 'Laura Martínez',
      'duracion': 24,
      'nivel': 'Intermedio',
      'icono': 'phone_android',
      'color': 0xFF4263EB,
    },
    {
      'nombre': 'Fundamentos de Python',
      'docente': 'Andrés Gómez',
      'duracion': 18,
      'nivel': 'Principiante',
      'icono': 'code',
      'color': 0xFF0F9D8A,
    },
    {
      'nombre': 'Ciberseguridad esencial',
      'docente': 'Camila Torres',
      'duracion': 20,
      'nivel': 'Intermedio',
      'icono': 'shield',
      'color': 0xFF8B5CF6,
    },
    {
      'nombre': 'Bases de datos SQL',
      'docente': 'Daniel Rojas',
      'duracion': 16,
      'nivel': 'Principiante',
      'icono': 'storage',
      'color': 0xFFF59E0B,
    },
    {
      'nombre': 'Diseño UX/UI',
      'docente': 'Valentina Ruiz',
      'duracion': 14,
      'nivel': 'Principiante',
      'icono': 'palette',
      'color': 0xFFEC4899,
    },
    {
      'nombre': 'Redes y servicios cloud',
      'docente': 'Felipe Castro',
      'duracion': 22,
      'nivel': 'Avanzado',
      'icono': 'cloud',
      'color': 0xFF0891B2,
    },
  ];

  // Simula una consulta remota usando Future, async y await.
  static Future<List<Map<String, dynamic>>> loadCourses() async {
    await Future.delayed(const Duration(seconds: 2));
    return courses;
  }
}
