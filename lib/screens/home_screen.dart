import 'package:flutter/material.dart';
import '../data/course_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> courses = [];
  String selectedLevel = 'Todos';

  @override
  void initState() {
    super.initState();
    _loadCourses();
  }

  Future<void> _loadCourses() async {
    final result = await CourseData.loadCourses();
    if (!mounted) return;
    setState(() {
      courses = result;
      isLoading = false;
    });
  }

  List<Map<String, dynamic>> get visibleCourses {
    if (selectedLevel == 'Todos') return courses;
    return courses.where((course) => course['nivel'] == selectedLevel).toList();
  }

  IconData _courseIcon(String name) {
    switch (name) {
      case 'phone_android':
        return Icons.phone_android_rounded;
      case 'code':
        return Icons.code_rounded;
      case 'shield':
        return Icons.shield_rounded;
      case 'storage':
        return Icons.storage_rounded;
      case 'palette':
        return Icons.palette_rounded;
      default:
        return Icons.cloud_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.school_rounded, size: 28),
            SizedBox(width: 10),
            Text('AulaTech', style: TextStyle(fontWeight: FontWeight.w800)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white.withValues(alpha: 0.16),
              child: const Icon(Icons.person_outline_rounded, color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: isLoading ? _buildLoading() : _buildCatalog(),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(strokeWidth: 4),
          SizedBox(height: 24),
          Text('Preparando tu aprendizaje...',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          SizedBox(height: 8),
          Text('Estamos cargando el catálogo de cursos.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF68738B))),
        ],
      ),
    );
  }

  Widget _buildCatalog() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF101B3F), Color(0xFF344FC4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('APRENDE ALGO NUEVO',
                  style: TextStyle(
                    color: Color(0xFFBFCBFF),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3,
                    fontSize: 12,
                  )),
              SizedBox(height: 12),
              Text('Tu próximo nivel\ncomienza aquí.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 29,
                    height: 1.15,
                    fontWeight: FontWeight.w800,
                  )),
              SizedBox(height: 12),
              Text('Explora cursos prácticos para impulsar tu futuro.',
                  style: TextStyle(color: Colors.white70, fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 26),
        Row(
          children: [
            const Expanded(
              child: Text('Catálogo de cursos',
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF17213D),
                  )),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFE7ECFF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('${visibleCourses.length} cursos',
                  style: const TextStyle(
                    color: Color(0xFF344FC4),
                    fontWeight: FontWeight.w700,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ['Todos', 'Principiante', 'Intermedio', 'Avanzado'].map((level) {
            final selected = selectedLevel == level;
            return ChoiceChip(
              label: Text(level),
              selected: selected,
              onSelected: (_) => setState(() => selectedLevel = level),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        if (visibleCourses.isEmpty)
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text('No hay cursos para este nivel.'),
          )
        else
          ...visibleCourses.map(_buildCourseCard),
        const SizedBox(height: 12),
        const Center(
          child: Text('AulaTech • Aprende a tu ritmo',
              style: TextStyle(color: Color(0xFF7A8499), fontSize: 12)),
        ),
      ],
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    final color = Color(course['color'] as int);
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE9EDF5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF17213D).withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(_courseIcon(course['icono'] as String),
                color: color, size: 28),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(course['nombre'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF17213D),
                    )),
                const SizedBox(height: 6),
                Text('Docente: ${course['docente']}',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF68738B),
                    )),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _infoTag(Icons.schedule_rounded, '${course['duracion']} horas'),
                    _infoTag(Icons.bar_chart_rounded, course['nivel'] as String),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTag(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5FA),
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF68738B)),
          const SizedBox(width: 5),
          Text(text,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF46516A),
              )),
        ],
      ),
    );
  }
}
