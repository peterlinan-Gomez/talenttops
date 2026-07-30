import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://eficwfdiudoiuufgqtuo.supabase.co',
    publishableKey: 'sb_publishable__qygqExiL9toOS3Xcon3DQ_23e40KUl',
  );

  runApp(const TalenttopsApp());
}

class TalenttopsApp extends StatelessWidget {
  const TalenttopsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talenttops',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 0, 90, 150)),
        useMaterial3: true,
      ),
      home: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  List<Widget> _getScreens(BuildContext context) {
    return [
      const SocialFeedScreen(), // El corazón de Talenttops: Red Social
      const Center(
          child: Text('📅 Servicios, Contratos e Impuestos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
      const Center(
          child: Text('👤 Mi Perfil de Reputación',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreens(context)[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.forum_outlined),
            label: 'Red Social',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman_outlined),
            label: 'Misiones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: 'Mi Gremio',
          ),
        ],
      ),
    );
  }
}

// =========================================================================
// FEED DE LA RED SOCIAL
// =========================================================================
class SocialFeedScreen extends StatelessWidget {
  const SocialFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> posts = [
      {
        'autor': 'Carlos Mendoza ⚡',
        'cargo': 'Héroe de Electricidad y Redes',
        'tiempo': 'Hace 10 min',
        'texto':
            '¡Trabajo terminado! Acabo de completar el cambio de tablero y colocación de llaves térmicas en un restaurante de Miraflores. RUC activo y recibo por honorarios emitido de inmediato para la deducción del cliente. 💼🇵🇪',
        'likes': 24,
        'insignia': 'Verificado',
        'colorInsignia': Colors.teal,
        'esVideo': false,
      },
      {
        'autor': 'Margarita Silva 📸',
        'cargo': 'Exploradora en Tiempo Real',
        'tiempo': 'Hace 2 horas',
        'texto':
            '¡En vivo desde el Puente de los Suspiros en Barranco! El cliente me contrató para verificar la fila del restaurante y el clima actual. Acabo de subirle el video de 1 minuto en tiempo real. ¡Misión cumplida! 🕶️✨',
        'likes': 42,
        'insignia': 'Top Corresponsal',
        'colorInsignia': Colors.orange,
        'esVideo': true,
      },
      {
        'autor': 'Jorge Huamán 🧱',
        'cargo': 'Maestro de Acabados y Albañilería',
        'tiempo': 'Hace 1 día',
        'texto':
            'Aprobé el micro-curso de "Diseño Sismorresistente en Estructuras" patrocinado por Aceros Arequipa en Talenttops. ¡Nueva medalla de logro desbloqueada! Subiendo mi nivel para postular a mejores misiones.',
        'likes': 56,
        'insignia': 'Talenttops Elite',
        'colorInsignia': Colors.red,
        'esVideo': false,
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Talenttops Social',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.teal)),
        backgroundColor: Colors.teal.shade50,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_moderator_rounded, color: Colors.red),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AccesoMisionesScreen()),
              );
            },
            tooltip: 'Unirte al Gremio',
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.red.shade700,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Expanded(
                  child: Text(
                    '¿Buscas ofrecer talento o contratar un Héroe verificado? Regístrate aquí.',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red.shade700,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccesoMisionesScreen()),
                    );
                  },
                  child: const Text('Comenzar', style: TextStyle(fontSize: 11)),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.teal.shade100,
                              child: Text(post['autor']![0],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        post['autor']!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: post['colorInsignia']
                                              .withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(6),
                                        ),
                                        child: Text(
                                          post['insignia']!,
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                              color: post['colorInsignia']),
                                        ),
                                      )
                                    ],
                                  ),
                                  Text(
                                    post['cargo']!,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black54),
                                  ),
                                  Text(
                                    post['tiempo']!,
                                    style: const TextStyle(
                                        fontSize: 10, color: Colors.black38),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          post['texto']!,
                          style: const TextStyle(
                              fontSize: 13.5,
                              color: Colors.black87,
                              height: 1.35),
                        ),
                        if (post['esVideo']) ...[
                          const SizedBox(height: 12),
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                              image: const DecorationImage(
                                image: NetworkImage(
                                    'https://images.unsplash.com/photo-1590523277543-a94d2e4eb00b?w=500&auto=format&fit=crop'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.black.withOpacity(0.6),
                                radius: 25,
                                child: const Icon(Icons.play_arrow_rounded,
                                    color: Colors.white, size: 30),
                              ),
                            ),
                          )
                        ],
                        const Divider(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.thumb_up_alt_outlined,
                                  size: 18, color: Colors.teal),
                              label: Text('${post['likes']} Aplausos',
                                  style: const TextStyle(
                                      color: Colors.teal, fontSize: 12)),
                            ),
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.comment_bank_outlined,
                                  size: 18, color: Colors.black54),
                              label: const Text('Recomendar',
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 12)),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade700,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 14, vertical: 6),
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Abriendo chat directo con ${post['autor']} 🦸‍♀️🛡️')),
                                );
                              },
                              child: const Text('Conectar',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. COMPUERTA DE ACCESO (AccesoMisionesScreen)
// ==========================================
class AccesoMisionesScreen extends StatefulWidget {
  const AccesoMisionesScreen({super.key});

  @override
  State<AccesoMisionesScreen> createState() => _AccesoMisionesScreenState();
}

class _AccesoMisionesScreenState extends State<AccesoMisionesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _bounceAnimation;

  @override
  void initState() {
    super.initState();
    // Controlador de animación nativo y gratuito
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.96, end: 1.04).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _bounceAnimation = Tween<double>(begin: 0.0, end: -8.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _simularLoginSocial(BuildContext context, String redSocial) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Conectando con $redSocial...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _irADesarrolloGratuito(BuildContext context) {
    // Redirige o inicia el flujo para quienes quieren desarrollar habilidades gratis
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SeleccionGeneroScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenido a Talenttops'),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // LOGO ANIMADO INTERACTIVO (Funciona como Botón)
              AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  return Transform.translate(
                    offset: Offset(0, _bounceAnimation.value),
                    child: Transform.scale(
                      scale: _scaleAnimation.value,
                      child: child,
                    ),
                  );
                },
                child: GestureDetector(
                  onTap: () => _irADesarrolloGratuito(context),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/Logo_Talenttops.png',
                      height: 200,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // LEYENDA DE LLAMADO A LA ACCIÓN (Desarrolla tu talento gratis)
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SeleccionGeneroScreen()),
                    );
                  },
                  child: const Text(
                    'Desarrolla tu talento gratis, da clic aquí',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0A66C2),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              const Text(
                'Conecta tu Talento al Mundo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Inicia sesión o regístrate con tus redes sociales para unirte a la red profesional y de empleo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),

              // Botón de Ingresar
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                icon: const Icon(Icons.shield_rounded, color: Colors.white),
                label: const Text(
                  'Ingresar',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A66C2),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SeleccionGeneroScreen(),
                    ),
                  );
                },
                icon:
                    const Icon(Icons.mail_outline_rounded, color: Colors.white),
                label: const Text(
                  'Registrarse con Correo',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A66C2),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Divisor visual
              const Row(
                children: [
                  Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'o continúa con redes sociales',
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ),
                  Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Google
              ElevatedButton.icon(
                onPressed: () {
                  _simularLoginSocial(context, 'Google');
                },
                icon: const Icon(Icons.g_mobiledata, size: 28),
                label: const Text(
                  'Continuar con Google',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black87,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 3. Facebook
              ElevatedButton.icon(
                onPressed: () {
                  _simularLoginSocial(context, 'Facebook');
                },
                icon: const Icon(Icons.facebook, color: Colors.white),
                label: const Text(
                  'Continuar con Facebook',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1877F2),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // 4. LinkedIn
              OutlinedButton.icon(
                onPressed: () {
                  _simularLoginSocial(context, 'LinkedIn');
                },
                icon: const Icon(Icons.work, color: Color(0xFF0077B5)),
                label: const Text(
                  'Continuar con LinkedIn',
                  style: TextStyle(
                      fontSize: 15,
                      color: Color(0xFF0077B5),
                      fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF0077B5), width: 1.5),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// REGISTRO WEB PÚBLICO (SeleccionGeneroScreen)
// ==========================================

class SeleccionGeneroScreen extends StatefulWidget {
  const SeleccionGeneroScreen({super.key});

  @override
  State<SeleccionGeneroScreen> createState() => _SeleccionGeneroScreenState();
}

class _SeleccionGeneroScreenState extends State<SeleccionGeneroScreen> {
  String _paisSeleccionado = 'PE'; // Código por defecto para Perú
  String _codigoTelefono = '+51'; // Código telefónico por defecto
  String? _generoSeleccionado;
  Uint8List? _webImageBytes;
  String? _fotoUrl;
  Future<void> _seleccionarFoto() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 85,
    );

    if (image != null) {
      final bytes = await image.readAsBytes();
      setState(() {
        _webImageBytes = bytes;
      });
    }
  }

  final _nombreController = TextEditingController();
  final _correoController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _documentoController = TextEditingController();
  final _rucController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Lista de países de América con códigos ISO y prefijos telefónicos oficiales
  final List<Map<String, String>> _paisesAmerica = [
    {'codigo': 'AR', 'nombre': 'Argentina', 'prefijo': '+54'},
    {'codigo': 'BO', 'nombre': 'Bolivia', 'prefijo': '+591'},
    {'codigo': 'BR', 'nombre': 'Brasil', 'prefijo': '+55'},
    {'codigo': 'CA', 'nombre': 'Canadá', 'prefijo': '+1'},
    {'codigo': 'CL', 'nombre': 'Chile', 'prefijo': '+56'},
    {'codigo': 'CO', 'nombre': 'Colombia', 'prefijo': '+57'},
    {'codigo': 'CR', 'nombre': 'Costa Rica', 'prefijo': '+506'},
    {'codigo': 'CU', 'nombre': 'Cuba', 'prefijo': '+53'},
    {'codigo': 'EC', 'nombre': 'Ecuador', 'prefijo': '+593'},
    {'codigo': 'SV', 'nombre': 'El Salvador', 'prefijo': '+503'},
    {'codigo': 'US', 'nombre': 'Estados Unidos', 'prefijo': '+1'},
    {'codigo': 'GT', 'nombre': 'Guatemala', 'prefijo': '+502'},
    {'codigo': 'HN', 'nombre': 'Honduras', 'prefijo': '+504'},
    {'codigo': 'MX', 'nombre': 'México', 'prefijo': '+52'},
    {'codigo': 'NI', 'nombre': 'Nicaragua', 'prefijo': '+505'},
    {'codigo': 'PA', 'nombre': 'Panamá', 'prefijo': '+507'},
    {'codigo': 'PY', 'nombre': 'Paraguay', 'prefijo': '+595'},
    {'codigo': 'PE', 'nombre': 'Perú', 'prefijo': '+51'},
    {'codigo': 'DO', 'nombre': 'República Dominicana', 'prefijo': '+1'},
    {'codigo': 'UY', 'nombre': 'Uruguay', 'prefijo': '+598'},
    {'codigo': 'VE', 'nombre': 'Venezuela', 'prefijo': '+58'},
  ];

  Future<void> _procesarRegistro() async {
    if (_nombreController.text.isEmpty ||
        _correoController.text.isEmpty ||
        _telefonoController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor completa Nombre, Correo y Teléfono'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    try {
      final AuthResponse response = await Supabase.instance.client.auth.signUp(
        email: _correoController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final User? user = response.user;

      if (user != null) {
        try {
          if (_webImageBytes != null) {
            final fileName =
                '${user.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';

            await Supabase.instance.client.storage
                .from('avatars')
                .uploadBinary(fileName, _webImageBytes!);

            _fotoUrl = Supabase.instance.client.storage
                .from('avatars')
                .getPublicUrl(fileName);
          } else {
            _fotoUrl = '';
          }

          debugPrint("Intentando guardar en la tabla user...");

          await Supabase.instance.client.from('user').upsert({
            'id': user.id,
            'full_name': _nombreController.text.trim(),
            'email': _correoController.text.trim(),
            'pais': _paisSeleccionado,
            'telefono': '$_codigoTelefono ${_telefonoController.text.trim()}',
            'documento': _documentoController.text.trim(),
            'ruc': _rucController.text.trim(),
            'genero': _generoSeleccionado ?? 'No especificado',
            'foto': _fotoUrl,
          });

          debugPrint("¡Guardado exitoso en la tabla user!");
        } catch (e) {
          debugPrint("ERROR CRITICO AL GUARDAR EN USER: $e");
        }
      }

      if (!mounted) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Row(
            children: [
              Icon(Icons.mark_email_unread_rounded, color: Color(0xFF0A66C2)),
              SizedBox(width: 8),
              Text('¡Verifica tu cuenta!'),
            ],
          ),
          content: const Text(
            'Hemos enviado un correo electrónico de confirmación a tu bandeja de entrada.\n\n'
            'Haz clic en el botón "Aceptar solicitud" del mensaje para activar tu cuenta.',
            style: TextStyle(fontSize: 14, height: 1.4),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A66C2),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SimuladorCorreoScreen(),
                  ),
                );
              },
              child: const Text('Enviar correo de confirmación',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error en el registro: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro Talenttops'),
        backgroundColor: const Color(0xFFF8F9FA),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: GestureDetector(
                  onTap: _seleccionarFoto,
                  child: Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200],
                          border: Border.all(
                              color: const Color(0xFF0A66C2), width: 2),
                          image: _webImageBytes != null
                              ? DecorationImage(
                                  image: MemoryImage(_webImageBytes!),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _webImageBytes == null
                            ? const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 24),
                                  Text(
                                    'Sonriele a la vida',
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 15),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )
                            : null,
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF0A66C2),
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Crea tu cuenta profesional',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Completa tus datos para unirte a Talenttops.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Nombre completo
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(
                  labelText: 'Nombre completo',
                  prefixIcon: const Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Correo electrónico
              TextField(
                controller: _correoController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Selector de País con Banderas y actualización de prefijo
              DropdownButtonFormField<String>(
                value: _paisSeleccionado,
                decoration: InputDecoration(
                  labelText: 'País de residencia',
                  prefixIcon: const Icon(Icons.public_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                items: _paisesAmerica.map((pais) {
                  return DropdownMenuItem<String>(
                    value: pais['codigo'],
                    child: Row(
                      children: [
                        CountryFlag.fromCountryCode(
                          pais['codigo']!,
                          height: 18,
                          width: 26,
                        ),
                        const SizedBox(width: 12),
                        Text('${pais['nombre']} (${pais['prefijo']})'),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? nuevoCodigo) {
                  if (nuevoCodigo != null) {
                    setState(() {
                      _paisSeleccionado = nuevoCodigo;
                      final paisEncontrado = _paisesAmerica
                          .firstWhere((p) => p['codigo'] == nuevoCodigo);
                      _codigoTelefono = paisEncontrado['prefijo']!;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Fila de Número Telefónico con Prefijo de País Automático
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      _codigoTelefono,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _telefonoController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Número telefónico',
                        prefixIcon: const Icon(Icons.phone_iphone_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Documento de identidad
              TextField(
                controller: _documentoController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Documento de identidad (DNI / Pasaporte)',
                  prefixIcon: const Icon(Icons.badge_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // RUC (Opcional)
              TextField(
                controller: _rucController,
                keyboardType: TextInputType.number,
                maxLength: 11,
                decoration: InputDecoration(
                  labelText: 'RUC (Opcional, si cuenta con uno)',
                  prefixIcon: const Icon(Icons.business_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  counterText: '',
                ),
              ),
              const SizedBox(height: 16),
// Opciones de Género Verticales
              const Text(
                'Género',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              RadioListTile<String>(
                title: const Text('Masculino', style: TextStyle(fontSize: 14)),
                value: 'Masculino',
                groupValue: _generoSeleccionado,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _generoSeleccionado = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Femenino', style: TextStyle(fontSize: 14)),
                value: 'Femenino',
                groupValue: _generoSeleccionado,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _generoSeleccionado = value;
                  });
                },
              ),
              RadioListTile<String>(
                title: const Text('Otro / Prefiero no decirlo',
                    style: TextStyle(fontSize: 14)),
                value: 'Otro / Prefiero no decirlo',
                groupValue: _generoSeleccionado,
                contentPadding: EdgeInsets.zero,
                onChanged: (value) {
                  setState(() {
                    _generoSeleccionado = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              // Contraseña
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Confirmar Contraseña
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Confirmar contraseña',
                  prefixIcon: const Icon(Icons.lock_reset_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Botón de Registro
              ElevatedButton(
                onPressed: _procesarRegistro,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A66C2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Regístrate con tu correo',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// FILTRO DE EXPERIENCIA
// =========================================================================
class FiltroExperienciaScreen extends StatelessWidget {
  final String genero;
  const FiltroExperienciaScreen({super.key, required this.genero});

  @override
  Widget build(BuildContext context) {
    String titulo = genero == 'femenino'
        ? '¡Bienvenida, Heroína!'
        : (genero == 'otros' ? '¡Bienvenido/a!' : '¡Bienvenido, Héroe!');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tu Trayectoria',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.red.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.history_edu_outlined, size: 75, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              titulo,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Para asignarte las misiones de manera correcta y segura, cuéntanos si tienes experiencia laboral previa en oficios o servicios.',
              style: TextStyle(fontSize: 15, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 45),
            ElevatedButton.icon(
              icon: const Icon(Icons.verified_user_outlined),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.red.shade700,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RegistroExperienciaPreviaScreen(genero: genero),
                  ),
                );
              },
              label: const Text('Sí, tengo experiencia trabajando',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              icon: const Icon(Icons.psychology_outlined),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                side: BorderSide(color: Colors.red.shade700, width: 2),
                foregroundColor: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegistroTalentoScreen(genero: genero),
                  ),
                );
              },
              label: const Text('No, quiero descubrir mi vocación',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================================================================
// REGISTRO CON EXPERIENCIA PREVIA
// =========================================================================
class RegistroExperienciaPreviaScreen extends StatefulWidget {
  final String genero;
  const RegistroExperienciaPreviaScreen({super.key, required this.genero});

  @override
  State<RegistroExperienciaPreviaScreen> createState() =>
      _RegistroExperienciaPreviaScreenState();
}

class _RegistroExperienciaPreviaScreenState
    extends State<RegistroExperienciaPreviaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otrosTalentosController = TextEditingController();

  bool _expCarpinteria = false;
  bool _expAlbanileria = false;
  bool _expGasfiteria = false;
  bool _expElectricidad = false;
  bool _expExploradorRealTime = false;
  bool _expCocina = false;
  bool _expLimpieza = false;
  bool _expTaxi = false;
  bool _expReparto = false;
  bool _expOtros = false;

  bool _cvCargado = false;
  String _nombreCvArchivo = '';

  String _aniosExperiencia = 'Menos de 1 año';
  String _nivelEstudios = 'Secundaria Completa';
  String _estadoRuc = 'No tengo RUC, pero quiero tramitarlo gratis';

  @override
  void dispose() {
    _otrosTalentosController.dispose();
    super.dispose();
  }

  void _mostrarDialogoBeneficiosRuc() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.gavel_rounded, color: Colors.teal),
            SizedBox(width: 10),
            Text('Beneficio SUNAT (RUC 10)'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '¿Por qué te conviene tener RUC activo en Talenttops?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• El cliente que te contrate deduce hasta el 30% del gasto de sus impuestos anuales ante la SUNAT. ¡Esto te convierte en un perfil preferencial y más cotizado!\n'
                '• Emitir Recibos por Honorarios electrónicos (RHE) es 100% gratuito.\n'
                '• No pagas impuestos si tus ingresos anuales son menores al límite legal vigente de Rentas de Cuarta Categoría.\n'
                '• Te abre las puertas a historial crediticio en bancos formales.',
                style: TextStyle(fontSize: 13, height: 1.4),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Entendido'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Declarar Experiencia',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.red.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '¿En qué áreas te has desempeñado?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                'Marca todas las opciones en las que cuentes con experiencia laboral comprobable.',
                style: TextStyle(fontSize: 13, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              CheckboxListTile(
                title: const Text('Carpintería y Estructuras de madera 🪵'),
                value: _expCarpinteria,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _expCarpinteria = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Albañilería y Acabados de construcción 🧱'),
                value: _expAlbanileria,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _expAlbanileria = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Gasfitería e Instalaciones Sanitarias 🪠'),
                value: _expGasfiteria,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _expGasfiteria = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Electricidad y Redes de Energía ⚡'),
                value: _expElectricidad,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _expElectricidad = val ?? false),
              ),
              CheckboxListTile(
                title:
                    const Text('Explorador en Tiempo Real (Fotos/Videos) 📸'),
                subtitle: const Text(
                    'Verificar estado actual de restaurantes, playas o rutas turísticas.'),
                value: _expExploradorRealTime,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _expExploradorRealTime = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Cocina / Preparación de alimentos 🍳'),
                value: _expCocina,
                activeColor: Colors.red.shade700,
                onChanged: (val) => setState(() => _expCocina = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Limpieza de Hogares u Oficinas 🧹'),
                value: _expLimpieza,
                activeColor: Colors.red.shade700,
                onChanged: (val) => setState(() => _expLimpieza = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Conducción / Taxi verificado 🚕'),
                value: _expTaxi,
                activeColor: Colors.red.shade700,
                onChanged: (val) => setState(() => _expTaxi = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Reparto / Courier motorizado 🛵'),
                value: _expReparto,
                activeColor: Colors.red.shade700,
                onChanged: (val) => setState(() => _expReparto = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Otros (Especificar experiencia propia) ✏️'),
                value: _expOtros,
                activeColor: Colors.red.shade700,
                onChanged: (val) => setState(() => _expOtros = val ?? false),
              ),
              if (_expOtros) ...[
                const SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormField(
                    controller: _otrosTalentosController,
                    maxLines: 3,
                    maxLength: 250,
                    decoration: InputDecoration(
                      labelText: 'Describe detalladamente tu oficio o talento',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fillColor: Colors.grey.shade50,
                      filled: true,
                    ),
                    validator: (value) {
                      if (_expOtros &&
                          (value == null || value.trim().isEmpty)) {
                        return 'Por favor describe el talento que dominas.';
                      }
                      return null;
                    },
                  ),
                ),
              ],
              const Divider(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Formalización Tributaria (RUC SUNAT) 💼',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  IconButton(
                    icon: const Icon(Icons.info_outline, color: Colors.teal),
                    onPressed: _mostrarDialogoBeneficiosRuc,
                  )
                ],
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _estadoRuc,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  prefixIcon:
                      Icon(Icons.gavel_rounded, color: Colors.teal.shade700),
                ),
                isExpanded: true,
                items: <String>[
                  'Ya cuento con RUC activo (Emisión de Recibos)',
                  'No tengo RUC, pero quiero tramitarlo gratis',
                  'Tramitar por mí con el Asesor Express (S/. 12)',
                  'Por el momento no deseo tramitar RUC'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: const TextStyle(fontSize: 13)),
                  );
                }).toList(),
                onChanged: (val) {
                  setState(() {
                    _estadoRuc =
                        val ?? 'No tengo RUC, pero quiero tramitarlo gratis';
                  });
                },
              ),
              const Divider(height: 40),
              const Text(
                'Sube tu Currículum Vitae (Recomendado) 📄',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 12),
              InkWell(
                onTap: () {
                  setState(() {
                    _cvCargado = true;
                    _nombreCvArchivo = widget.genero == 'femenino'
                        ? 'CV_Heroina_Talenttops.pdf'
                        : 'CV_Heroe_Talenttops.pdf';
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '¡✓ $_nombreCvArchivo cargado! Analizando experiencia... 🧠⚙️'),
                      backgroundColor: Colors.teal.shade700,
                    ),
                  );
                },
                child: Card(
                  color: _cvCargado ? Colors.teal.shade50 : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: _cvCargado
                          ? Colors.teal.shade400
                          : Colors.grey.shade300,
                      width: _cvCargado ? 1.5 : 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          _cvCargado
                              ? Icons.picture_as_pdf_rounded
                              : Icons.cloud_upload_outlined,
                          color: _cvCargado
                              ? Colors.teal.shade700
                              : Colors.grey.shade600,
                          size: 36,
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _cvCargado
                                    ? '¡Currículum Cargado!'
                                    : 'Selecciona tu CV',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: _cvCargado
                                      ? Colors.teal.shade900
                                      : Colors.black87,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _cvCargado
                                    ? _nombreCvArchivo
                                    : 'Formatos permitidos: PDF, Word o Foto.',
                                style: TextStyle(
                                  fontSize: 11.5,
                                  color: _cvCargado
                                      ? Colors.teal.shade800
                                      : Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (_cvCargado)
                          const Icon(Icons.check_circle_rounded,
                              color: Colors.green, size: 24)
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(height: 40),
              const Text(
                '¿Cuánto tiempo de experiencia tienes en total?',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _aniosExperiencia,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: <String>[
                  'Menos de 1 año',
                  '1 a 3 años',
                  '3 a 5 años',
                  'Más de 5 años'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) =>
                    setState(() => _aniosExperiencia = val ?? 'Menos de 1 año'),
              ),
              const SizedBox(height: 25),
              const Text(
                'Nivel de estudios alcanzado:',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: _nivelEstudios,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                items: <String>[
                  'Secundaria Incompleta',
                  'Secundaria Completa',
                  'Técnico en curso/completo',
                  'Universitario en curso/completo'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (val) => setState(
                    () => _nivelEstudios = val ?? 'Secundaria Completa'),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    if (!_expCarpinteria &&
                        !_expAlbanileria &&
                        !_expGasfiteria &&
                        !_expElectricidad &&
                        !_expExploradorRealTime &&
                        !_expCocina &&
                        !_expLimpieza &&
                        !_expTaxi &&
                        !_expReparto &&
                        !_expOtros) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Por favor, selecciona al menos una categoría o la opción "Otros". ⚠️')),
                      );
                      return;
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormularioRegistroHeroeScreen(
                          genero: widget.genero,
                          talentoOtros: _expOtros
                              ? _otrosTalentosController.text.trim()
                              : null,
                        ),
                      ),
                    );
                  },
                  child: const Text('Guardar y Continuar al Registro',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// TEST VOCACIONAL CON NEUROCIENCIA
// =========================================================================
class RegistroTalentoScreen extends StatefulWidget {
  final String genero;
  const RegistroTalentoScreen({super.key, required this.genero});

  @override
  State<RegistroTalentoScreen> createState() => _RegistroTalentoScreenState();
}

class _RegistroTalentoScreenState extends State<RegistroTalentoScreen> {
  int _currentPregunta = 0;

  int _empatiaMirror = 0;
  int _controlInhibitorio = 0;
  int _gestionRiesgo = 0;

  String _nivelEstudiosVocacional = 'Secundaria Completa';

  final List<Map<String, dynamic>> _preguntasNeuro = [
    {
      'titulo': 'Fase 1: Vocación de Servicio y Espejo Límbico 🤝',
      'descripcion':
          'Observa la imagen detalladamente. Imagina que un cliente reacciona con frustración o desespero ante un imprevisto en la tarea contratada. ¿Cuál es tu impulso subconsciente?',
      'imageUrl':
          'https://images.unsplash.com/photo-1516627145497-ae6968895b74?w=500&auto=format&fit=crop',
      'opciones': [
        {
          'texto':
              'Detengo lo que hago, busco contacto visual amable y valido su emoción antes de proponer cualquier solución.',
          'rasgo': 'empatia'
        },
        {
          'texto':
              'Mantengo el enfoque en resolver lo que causó el problema de manera metódica y racional.',
          'rasgo': 'control_inhibitorio'
        },
        {
          'texto':
              'Establezco límites firmes de inmediato para que la situación no se salga de control.',
          'rasgo': 'gestion_riesgo'
        }
      ]
    },
    {
      'titulo': 'Fase 2: Control de Entornos Dinámicos ⚡',
      'descripcion':
          'Mirando esta escena de saturación y sobrecarga visual. Te encuentras en un momento donde las demandas, órdenes y el ruido exterior colapsan tu entorno simultáneamente. ¿Cuál es tu primera línea de defensa mental?',
      'imageUrl':
          'https://images.unsplash.com/photo-1506784983877-45594efa4cbe?w=500&auto=format&fit=crop',
      'opciones': [
        {
          'texto':
              'Respiro hondo, aíslo el ruido exterior y organizo las prioridades una a una con cabeza fría.',
          'rasgo': 'control_inhibitorio'
        },
        {
          'texto':
              'Busco apoyo o coordino comunicación directa con las personas afectadas para calmar la urgencia en conjunto.',
          'rasgo': 'empatia'
        },
        {
          'texto':
              'Me enfoco estrictamente en las normativas y protocolos de seguridad para mitigar cualquier peligro físico.',
          'rasgo': 'gestion_riesgo'
        }
      ]
    },
    {
      'titulo': 'Fase 3: Dilema de Incertidumbre y Amígdala 🧭',
      'descripcion':
          'La imagen muestra un camino difuso bajo condiciones adversas. Estás realizando un servicio urgente y te enfrentas a un imprevisto que pone en riesgo tu puntualidad o tu seguridad. ¿Cómo responde tu instinto ante la amenaza?',
      'imageUrl':
          'https://images.unsplash.com/photo-1470071459604-3b5ec3a7fe05?w=500&auto=format&fit=crop',
      'opciones': [
        {
          'texto':
              'Asumo la responsabilidad, reporto la verdad de inmediato por la app y busco un desvío seguro aunque tarde más.',
          'rasgo': 'gestion_riesgo'
        },
        {
          'texto':
              'Intento acelerar el proceso asumiendo un riesgo controlado para cumplir la misión con el cliente.',
          'rasgo': 'control_inhibitorio'
        },
        {
          'texto':
              'Priorizo proteger el bienestar emocional de los involucrados en el trayecto antes de pensar en las consecuencias.',
          'rasgo': 'empatia'
        }
      ]
    }
  ];

  void _registrarRespuesta(String rasgo) {
    setState(() {
      if (rasgo == 'empatia') {
        _empatiaMirror++;
      }
      if (rasgo == 'control_inhibitorio') {
        _controlInhibitorio++;
      }
      if (rasgo == 'gestion_riesgo') {
        _gestionRiesgo++;
      }
      _currentPregunta++;
    });
  }

  String _getTituloBarra() {
    if (widget.genero == 'femenino') {
      return 'Encontrando tu Heroína interior';
    }
    if (widget.genero == 'otros') {
      return 'Encontrando tu potencial interior';
    }
    return 'Encontrando tu Héroe interior';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_getTituloBarra(),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
        backgroundColor: Colors.red.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _currentPregunta <= _preguntasNeuro.length
            ? _buildFlujoPreguntas()
            : _buildResultadoPersonalidad(),
      ),
    );
  }

  Widget _buildFlujoPreguntas() {
    if (_currentPregunta == _preguntasNeuro.length) {
      return _buildPreguntaEstudios();
    }

    final preguntaActual = _preguntasNeuro[_currentPregunta];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LinearProgressIndicator(
          value: (_currentPregunta + 1) / (_preguntasNeuro.length + 1),
          backgroundColor: Colors.grey.shade200,
          color: Colors.red.shade700,
        ),
        const SizedBox(height: 15),
        const Text(
          'Perfil Vocacional Activo',
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        const SizedBox(height: 5),
        Text(
          preguntaActual['titulo'],
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            preguntaActual['imageUrl'],
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 160,
                color: Colors.grey.shade200,
                child: const Icon(Icons.image_not_supported_outlined,
                    size: 40, color: Colors.grey),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Text(
          preguntaActual['descripcion'],
          style: const TextStyle(
              fontSize: 14, color: Colors.black87, height: 1.35),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: preguntaActual['opciones'].length,
            itemBuilder: (context, index) {
              final opcion = preguntaActual['opciones'][index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 12),
                    alignment: Alignment.centerLeft,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: Colors.red.shade200),
                  ),
                  onPressed: () => _registrarRespuesta(opcion['rasgo']),
                  child: Text(
                    opcion['texto'],
                    style: const TextStyle(
                        fontSize: 13.5,
                        color: Colors.black87,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPreguntaEstudios() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.school_outlined, size: 70, color: Colors.red),
        const SizedBox(height: 20),
        const Text(
          'Para cerrar el perfil vocacional:',
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        const Text(
          '¿Cuál es tu último grado académico alcanzado o en curso?',
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        const SizedBox(height: 20),
        DropdownButtonFormField<String>(
          value: _nivelEstudiosVocacional,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          items: <String>[
            'Secundaria Incompleta',
            'Secundaria Completa',
            'Técnico en curso/completo',
            'Universitario en curso/completo'
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (val) => setState(
              () => _nivelEstudiosVocacional = val ?? 'Secundaria Completa'),
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              setState(() {
                _currentPregunta++;
              });
            },
            child: const Text('Descubrir mi Perfil Vocacional',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildResultadoPersonalidad() {
    String rasgoPredominante = 'Perfil Balanceado';
    String iconoRasgo = '💎';
    String recomendacionTrabajo = '';
    String descripcionRasgo = '';

    if (_empatiaMirror >= _controlInhibitorio &&
        _empatiaMirror >= _gestionRiesgo) {
      rasgoPredominante = widget.genero == 'femenino'
          ? 'Empática / Conectora Límbica'
          : (widget.genero == 'otros'
              ? 'Empátique / Conectore Límbique'
              : 'Empático / Conector Límbico');
      iconoRasgo = '🤝';
      descripcionRasgo =
          'Tu lóbulo frontal demuestra una altísima actividad en neuronas espejo. Tienes una sensibilidad natural muy fuerte hacia el trato directo con clientes y el soporte humano.';
      recomendacionTrabajo =
          'Recomendación: Explorador en Tiempo Real, Cocina o Asistencia Administrativa.';
    } else if (_controlInhibitorio >= _empatiaMirror &&
        _controlInhibitorio >= _gestionRiesgo) {
      rasgoPredominante = 'Foco y Control Inhibitorio';
      iconoRasgo = '⛰️';
      descripcionRasgo =
          'Tu corteza prefrontal inhibe de forma extraordinaria las reacciones impulsivas frente al caos. Trabajas muy bien bajo presión y resuelves problemas técnicos de forma impecable.';
      recomendacionTrabajo =
          'Recomendación: Carpintería, Albañilería, Electricidad o Gasfitería.';
    } else {
      rasgoPredominante = widget.genero == 'femenino'
          ? 'Estratega / Gestora de Riesgo'
          : (widget.genero == 'otros'
              ? 'Estratega / Gestore de Riesgo'
              : 'Estratega / Gestor de Riesgo');
      iconoRasgo = '🦁';
      descripcionRasgo =
          'Tu cerebro prioriza de manera firme la ética, el cumplimiento de protocolos de seguridad y la prevención de contingencias.';
      recomendacionTrabajo =
          'Recomendación: Conducción de Vehículos (Taxi/Courier Seguro) o Logística de Envíos.';
    }

    String textoBoton = widget.genero == 'femenino'
        ? 'Completar Registro de Heroína'
        : (widget.genero == 'otros'
            ? 'Completar mi Registro'
            : 'Completar Registro de Héroe');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(iconoRasgo, style: const TextStyle(fontSize: 60)),
        const SizedBox(height: 15),
        Text(
          widget.genero == 'femenino'
              ? 'Esencia de Heroína Revelada:'
              : 'Esencia Revelada:',
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        Text(
          rasgoPredominante,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade800),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            descripcionRasgo,
            style: const TextStyle(
                fontSize: 14, color: Colors.black87, height: 1.4),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.green.shade200),
          ),
          child: Text(
            recomendacionTrabajo,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 35),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FormularioRegistroHeroeScreen(genero: widget.genero)),
              );
            },
            child: Text(textoBoton,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}

// =========================================================================
// FORMULARIO DE REGISTRO DE IDENTIDAD
// =========================================================================
class FormularioRegistroHeroeScreen extends StatefulWidget {
  final String genero;
  final String? talentoOtros;

  const FormularioRegistroHeroeScreen({
    super.key,
    required this.genero,
    this.talentoOtros,
  });

  @override
  State<FormularioRegistroHeroeScreen> createState() =>
      _FormularioRegistroHeroeScreenState();
}

class _FormularioRegistroHeroeScreenState
    extends State<FormularioRegistroHeroeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dniController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _correoController = TextEditingController();
  final _placaController = TextEditingController();
  final _modeloController = TextEditingController();

  bool _quiereTaxi = false;
  bool _quiereDelivery = false;
  bool _quiereLimpieza = false;
  bool _quiereOficios = false;
  bool _quiereExplorador = false;
  bool _quiereOtros = false;

  bool _fotoTomada = false;
  bool _cargoAntecedentes = false;
  bool _usoCreditoDeclaracion = false;

  @override
  void initState() {
    super.initState();
    if (widget.talentoOtros != null) {
      _quiereOtros = true;
    }
  }

  @override
  void dispose() {
    _dniController.dispose();
    _telefonoController.dispose();
    _correoController.dispose();
    _placaController.dispose();
    _modeloController.dispose();
    super.dispose();
  }

  String _getTituloRegistro() {
    if (widget.genero == 'femenino') {
      return 'Consolida tu Identidad de Heroína';
    }
    if (widget.genero == 'otros') {
      return 'Consolida tu Identidad';
    }
    return 'Consolida tu Identidad de Héroe';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Gremio',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getTituloRegistro(),
                style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 8),
              const Text(
                'Selecciona qué misiones deseas realizar para pedirte únicamente los documentos obligatorios por ley.',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 20),
              const Text('¿Qué tipo de misiones realizarás?',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 10),
              CheckboxListTile(
                title: const Text('Servicio de Taxi 🚕'),
                subtitle: const Text('Requiere brevete AII-a y SOAT vigente'),
                value: _quiereTaxi,
                activeColor: Colors.red.shade700,
                onChanged: (val) => setState(() => _quiereTaxi = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Servicio de Delivery / Reparto 🛵'),
                subtitle: const Text('Motos, autos o bicicletas'),
                value: _quiereDelivery,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _quiereDelivery = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Servicios Técnicos del Hogar 🛠️'),
                subtitle: const Text(
                    'Electricidad, Gasfitería, Carpintería o Albañilería'),
                value: _quiereOficios,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _quiereOficios = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Misiones de Exploración en Tiempo Real 📸'),
                subtitle: const Text(
                    'Verificación visual de locales, eventos o vías para clientes.'),
                value: _quiereExplorador,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _quiereExplorador = val ?? false),
              ),
              CheckboxListTile(
                title: const Text('Servicio de Limpieza / Hogar 🧹'),
                subtitle: const Text('Casas u oficinas de clientes'),
                value: _quiereLimpieza,
                activeColor: Colors.red.shade700,
                onChanged: (val) =>
                    setState(() => _quiereLimpieza = val ?? false),
              ),
              if (widget.talentoOtros != null) ...[
                Card(
                  color: Colors.amber.shade50,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: CheckboxListTile(
                    title: Text('Mi Habilidad Personalizada 🎨',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber.shade900)),
                    subtitle: Text('"${widget.talentoOtros}"'),
                    value: _quiereOtros,
                    activeColor: Colors.amber.shade800,
                    onChanged: (val) =>
                        setState(() => _quiereOtros = val ?? false),
                  ),
                ),
              ],
              const Divider(height: 40),
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.red.shade50,
                      child: Icon(
                        _fotoTomada
                            ? Icons.check_circle
                            : Icons.add_a_photo_outlined,
                        size: 40,
                        color: _fotoTomada ? Colors.green : Colors.red.shade700,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() => _fotoTomada = true);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text(
                                  'Foto facial tomada para validación biométrica. 📸')),
                        );
                      },
                      child: Text(_fotoTomada
                          ? '✓ Foto Registrada'
                          : 'Tomar Foto de Perfil (Selfie)'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _dniController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'DNI o Carnet de Extranjería',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa tu documento.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _telefonoController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Teléfono de Contacto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.phone_iphone_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingresa tu celular.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _correoController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa tu correo electrónico.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_quiereTaxi || _quiereDelivery) ...[
                const Text('Información del Vehículo',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _placaController,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    labelText: 'Número de Placa',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.directions_car),
                  ),
                  validator: (value) {
                    if ((_quiereTaxi || _quiereDelivery) &&
                        (value == null || value.isEmpty)) {
                      return 'La placa es obligatoria para transporte.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: _modeloController,
                  decoration: const InputDecoration(
                    labelText: 'Modelo y Año del Vehículo',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              const Text(
                'Validación de Antecedentes',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 12),
              Card(
                color: _cargoAntecedentes && !_usoCreditoDeclaracion
                    ? Colors.green.shade50
                    : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.grey.shade300),
                ),
                child: ListTile(
                  leading: Icon(Icons.upload_file, color: Colors.grey.shade700),
                  title: const Text('Subir mis PDF propios',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  onTap: () {
                    setState(() {
                      _cargoAntecedentes = true;
                      _usoCreditoDeclaracion = false;
                    });
                  },
                ),
              ),
              const SizedBox(height: 8),
              Card(
                color:
                    _usoCreditoDeclaracion ? Colors.blue.shade50 : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(
                      color: _usoCreditoDeclaracion
                          ? Colors.blue
                          : Colors.grey.shade300),
                ),
                child: ListTile(
                  leading: Icon(Icons.handshake_outlined,
                      color: Colors.blue.shade700),
                  title: const Text('Crédito con Declaración Jurada',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: Colors.blue)),
                  onTap: () {
                    setState(() {
                      _usoCreditoDeclaracion = true;
                      _cargoAntecedentes = true;
                    });
                  },
                ),
              ),
              const SizedBox(height: 35),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    if (!_quiereTaxi &&
                        !_quiereDelivery &&
                        !_quiereLimpieza &&
                        !_quiereOficios &&
                        !_quiereExplorador &&
                        !_quiereOtros) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Debes seleccionar al menos un tipo de misión. ⚠️')),
                      );
                      return;
                    }
                    if (!_fotoTomada) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content:
                                Text('Debes tomarte la foto de perfil. 📸')),
                      );
                      return;
                    }

                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const TableroMisionesScreen()),
                      );
                    }
                  },
                  child: const Text('Enviar Registro y Ver Misiones',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================================
// TABLERO DE MISIONES (CONTRATANTES)
// =========================================================================
class TableroMisionesScreen extends StatelessWidget {
  const TableroMisionesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> misiones = [
      {
        'titulo': 'Misión: Corresponsal en Barranco 📸🎥',
        'recompensa': '+70 XP | S/. 25',
        'categoria': 'Explorador en Tiempo Real',
        'descripcion':
            'Se necesita un explorador cerca al Puente de los Suspiros para transmitir video de 1 minuto mostrando la afluencia en un restaurante turístico.'
      },
      {
        'titulo': 'Misión: Emergencia por fugas de Agua 🪠',
        'recompensa': '+90 XP | S/. 75',
        'categoria': 'Gasfitería y Sanitarios',
        'descripcion':
            'Instalación de trampa de lavadero de cocina en segundo piso. Se busca respuesta rápida.'
      },
      {
        'titulo': 'Misión: Instalación Segura de Interruptores ⚡',
        'recompensa': '+80 XP | S/. 60',
        'categoria': 'Electricidad Básica',
        'descripcion':
            'Cambio de 3 interruptores antiguos en vivienda familiar.'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tablón de Misiones',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.red.shade100,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Misiones Activas',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: misiones.length,
                itemBuilder: (context, index) {
                  final mision = misiones[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                mision['categoria']!,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade700),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  mision['recompensa']!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade800),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            mision['titulo']!,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            mision['descripcion']!,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.black54),
                          ),
                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade700,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          '¡Has postulado a la ${mision['titulo']}! ⚔️')),
                                );
                              },
                              child: const Text('Aceptar Misión'),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SimuladorCorreoScreen extends StatelessWidget {
  const SimuladorCorreoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bandeja de Entrada (Simulador)'),
        backgroundColor: const Color(0xFF0A66C2),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.mark_email_read_outlined,
              size: 80,
              color: Color(0xFF0A66C2),
            ),
            const SizedBox(height: 24),
            const Text(
              'De: soporte@talenttops.com',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Confirma tu solicitud de registro',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text(
              'Has solicitado registrarte en Talenttops. Haz clic en el botón de abajo para aceptar la solicitud y activar tu cuenta.',
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Mensaje de éxito de activación y regreso o pase
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('¡Solicitud aceptada! Cuenta activada con éxito.'),
                    backgroundColor: Colors.green,
                  ),
                );

                // Regresar al inicio o mandar a la pantalla principal
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text(
                'Aceptar solicitud',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _correoController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  void _iniciarSesion() {
    final correo = _correoController.text.trim();
    final password = _passwordController.text.trim();

    if (correo.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor ingresa tu correo y contraseña'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Bienvenido de nuevo! Sesión iniciada con éxito.'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.popUntil(context, (route) => route.isFirst);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesión'),
        backgroundColor: const Color(0xFF0A66C2),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.shield_rounded,
                size: 80,
                color: Color(0xFF0A66C2),
              ),
              const SizedBox(height: 24),
              const Text(
                'Accede a tu cuenta',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _correoController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _iniciarSesion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0A66C2),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Ingresar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
