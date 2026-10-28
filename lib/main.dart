import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const App());

const kBrown = Color(0xFF5B2E1F);
const kPink = Color(0xFFD98A9B);

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Licorice Lip Balm',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: kBrown, secondary: kPink),
          scaffoldBackgroundColor: const Color(0xFFFBF5F1),
        ),
        home: const Shell(),
      );
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    const pages = [OverviewPage(), SciencePage(), FormulaPage(), StabilityPage(), QuizPage()];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Licorice Lip Balm', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: kBrown,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: pages[i],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: i,
        onDestinationSelected: (v) => setState(() => i = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Overview'),
          NavigationDestination(icon: Icon(Icons.science_outlined), label: 'Science'),
          NavigationDestination(icon: Icon(Icons.tune), label: 'Formula'),
          NavigationDestination(icon: Icon(Icons.show_chart), label: 'Stability'),
          NavigationDestination(icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
        ],
      ),
    );
  }
}

// ---------- helpers ----------
class Block extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;
  const Block(this.title, this.icon, this.children, {super.key});
  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.only(bottom: 14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Icon(icon, color: kBrown),
              const SizedBox(width: 8),
              Expanded(child: Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
            ]),
            const SizedBox(height: 10),
            ...children,
          ]),
        ),
      );
}

Widget bullet(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('•  '),
        Expanded(child: Text(t)),
      ]),
    );

// ---------- Overview ----------
class OverviewPage extends StatelessWidget {
  const OverviewPage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [kBrown, Color(0xFF9C5B49)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('Caffeine Beyond the Cup', style: TextStyle(color: Colors.white70)),
            SizedBox(height: 6),
            Text('Licorice Lip Balm', style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
            SizedBox(height: 6),
            Text('Glycyrrhiza glabra phytochemicals from root to lip: science, formulation and stability.',
                style: TextStyle(color: Colors.white)),
          ]),
        ),
        const SizedBox(height: 16),
        Block('Project aim', Icons.flag_outlined, [
          const Text('Combine Pharmacology, Phytochemistry, Pharmaceutical Chemistry and Pharmaceutics to develop and evaluate a lip balm containing licorice (Glycyrrhiza glabra) phytochemicals, valued for antioxidant, antibacterial and soothing properties.'),
        ]),
        Block('Four departments, one product', Icons.groups_outlined, [
          bullet('Phytochemistry: source, key compounds, extraction'),
          bullet('Pharmaceutical Chemistry: structures, properties, analysis'),
          bullet('Pharmacology: mechanisms and biological activity'),
          bullet('Pharmaceutics: dosage form, market products, kinetics and stability'),
        ]),
        Block('Market products (Pharmaceutics task)', Icons.storefront_outlined, [
          const Text('The brief asks for sterile market products containing the selected compound. Licorice lip balm itself is a non-sterile semi-solid (microbial limits apply, not sterility), so compare it with:'),
          const SizedBox(height: 6),
          bullet('Glycyrrhizin-containing injectables (e.g. glycyrrhizin / glycine / cysteine IV preparations used in some countries)'),
          bullet('Licorice or glycyrrhetinic acid topical products: creams, gels, lip care'),
          bullet('Ophthalmic or oral-care products reported to include licorice'),
          const SizedBox(height: 8),
          const Text('Verify brand names, concentrations and registration status from product leaflets or drug databases before adding them to your report.',
              style: TextStyle(fontStyle: FontStyle.italic)),
        ]),
        Block('Evaluation criteria', Icons.checklist, [
          bullet('Scientific accuracy and depth'),
          bullet('Integration of the four disciplines'),
          bullet('Creativity and innovation'),
          bullet('Quality of presentation'),
          bullet('Teamwork and communication'),
        ]),
      ]);
}

// ---------- Science ----------
class Compound {
  final String name, cls, polarity, info;
  final List<String> activity;
  const Compound(this.name, this.cls, this.polarity, this.info, this.activity);
}

const compounds = [
  Compound('Glycyrrhizin', 'Triterpenoid saponin', 'Hydrophilic (glycoside)',
      'The main sweet constituent of the root. Hydrolysed to glycyrrhetinic acid. Sweet taste helps palatability of a lip balm.',
      ['Anti-inflammatory', 'Soothing', 'Antiviral (reported)']),
  Compound('Glabridin', 'Isoflavan', 'Lipophilic',
      'A lipophilic polyphenol that dissolves well in the oil/wax base of a lip balm. Sensitive to light and oxidation.',
      ['Antioxidant', 'Anti-inflammatory', 'Skin brightening']),
  Compound('Liquiritin', 'Flavanone glycoside', 'Moderately hydrophilic',
      'A flavonoid glycoside contributing antioxidant effect and skin-tone evening.',
      ['Antioxidant', 'Antibacterial (reported)']),
  Compound('Glycyrrhetinic acid', 'Triterpenoid aglycone', 'Lipophilic',
      'Aglycone of glycyrrhizin; used topically for its calming effect on irritated skin.',
      ['Anti-inflammatory', 'Anti-irritant']),
];

class SciencePage extends StatefulWidget {
  const SciencePage({super.key});
  @override
  State<SciencePage> createState() => _SciencePageState();
}

class _SciencePageState extends State<SciencePage> {
  int sel = 0;
  @override
  Widget build(BuildContext context) {
    final c = compounds[sel];
    return ListView(padding: const EdgeInsets.all(16), children: [
      Text('Tap a compound', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 8),
      Wrap(spacing: 8, runSpacing: 8, children: [
        for (int i = 0; i < compounds.length; i++)
          ChoiceChip(
            label: Text(compounds[i].name),
            selected: sel == i,
            onSelected: (_) => setState(() => sel = i),
          ),
      ]),
      const SizedBox(height: 12),
      Block(c.name, Icons.bubble_chart, [
        Text('Class: ${c.cls}'),
        Text('Solubility: ${c.polarity}'),
        const SizedBox(height: 8),
        Text(c.info),
        const SizedBox(height: 10),
        Wrap(spacing: 6, children: [for (final a in c.activity) Chip(label: Text(a))]),
      ]),
      Block('Pharmacology in the lip balm', Icons.healing_outlined, [
        bullet('Antioxidant: scavenges free radicals from UV and air exposure.'),
        bullet('Antibacterial: reported activity against skin and oral bacteria.'),
        bullet('Anti-inflammatory: calms chapped, irritated lips.'),
        const SizedBox(height: 6),
        const Text('Topical use at low concentration: systemic effects of oral licorice (raised blood pressure, low potassium) are not expected from a lip balm, but should be discussed in your safety section.',
            style: TextStyle(fontStyle: FontStyle.italic)),
      ]),
      Block('Phytochemistry workflow', Icons.account_tree_outlined, [
        bullet('Dried root, then powdering'),
        bullet('Extraction (ethanol/water maceration or ultrasound)'),
        bullet('Filtration and concentration'),
        bullet('Standardisation by HPLC or UV'),
        bullet('Incorporation into the lip balm base'),
      ]),
    ]);
  }
}

// ---------- Formula builder ----------
class FormulaPage extends StatefulWidget {
  const FormulaPage({super.key});
  @override
  State<FormulaPage> createState() => _FormulaPageState();
}

class _FormulaPageState extends State<FormulaPage> {
  double wax = 25, butter = 20, extract = 3, vitE = 0.5;
  double get oil => 100 - wax - butter - extract - vitE;

  String get texture {
    if (oil < 0) return 'Invalid: total exceeds 100%';
    final hard = wax / (wax + butter + oil);
    if (hard > 0.40) return 'Very firm, may drag on lips';
    if (hard > 0.22) return 'Firm stick, good glide';
    return 'Soft, may deform in warm conditions';
  }

  Widget slider(String label, double v, double min, double max, ValueChanged<double> f) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ${v.toStringAsFixed(1)}%'),
          Slider(value: v, min: min, max: max, divisions: ((max - min) * 2).round(), onChanged: f),
        ],
      );

  @override
  Widget build(BuildContext context) {
    final ok = oil >= 0;
    return ListView(padding: const EdgeInsets.all(16), children: [
      Block('Formula builder (per 100 g)', Icons.tune, [
        slider('Beeswax', wax, 10, 40, (v) => setState(() => wax = v)),
        slider('Shea butter', butter, 5, 40, (v) => setState(() => butter = v)),
        slider('Licorice extract', extract, 0.5, 10, (v) => setState(() => extract = v)),
        slider('Vitamin E (antioxidant)', vitE, 0, 2, (v) => setState(() => vitE = v)),
      ]),
      Block('Result', Icons.assessment_outlined, [
        Text('Carrier oil (auto): ${oil.toStringAsFixed(1)}%'),
        const SizedBox(height: 6),
        Text('Texture: $texture', style: TextStyle(fontWeight: FontWeight.bold, color: ok ? kBrown : Colors.red)),
        const SizedBox(height: 10),
        if (ok)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 26,
              child: Row(children: [
                _seg(wax, const Color(0xFFE6B450), 'Wax'),
                _seg(butter, const Color(0xFFF0D9B5), 'Shea'),
                _seg(oil, const Color(0xFFCFA97A), 'Oil'),
                _seg(extract, kBrown, ''),
                _seg(vitE, kPink, ''),
              ]),
            ),
          ),
        const SizedBox(height: 8),
        const Text('Beeswax gives structure, shea butter gives softness, oil gives glide. Glabridin is lipophilic so it dissolves in the oil phase; use an oil-soluble or glycolic extract.'),
      ]),
      Block('Quality tests to report', Icons.fact_check_outlined, [
        bullet('Melting point, hardness and breaking force'),
        bullet('Appearance, colour, odour, spreadability'),
        bullet('Skin irritation (patch test)'),
        bullet('Microbial limits (total aerobic count, yeast and mould)'),
        bullet('Accelerated stability (40 °C / 75% RH)'),
      ]),
    ]);
  }

  Widget _seg(double v, Color c, String l) => Expanded(
        flex: max(1, (v * 10).round()),
        child: Container(color: c, alignment: Alignment.center, child: Text(l, style: const TextStyle(fontSize: 10))),
      );
}

// ---------- Stability / kinetics ----------
class StabilityPage extends StatefulWidget {
  const StabilityPage({super.key});
  @override
  State<StabilityPage> createState() => _StabilityPageState();
}

class _StabilityPageState extends State<StabilityPage> {
  double tempC = 25;
  bool light = false, oxygen = false, antiox = true;

  // Illustrative values: replace with your own experimental data.
  static const k25 = 0.0015; // 1/day at 25 C
  static const ea = 60000.0; // J/mol
  static const r = 8.314;

  double get k {
    final t = tempC + 273.15;
    var v = k25 * exp(ea / r * (1 / 298.15 - 1 / t));
    if (light) v *= 2.5;
    if (oxygen) v *= 1.5;
    if (antiox) v *= 0.5;
    return v;
  }

  @override
  Widget build(BuildContext context) {
    final t90 = log(10 / 9) / k;
    final tHalf = log(2) / k;
    return ListView(padding: const EdgeInsets.all(16), children: [
      Block('Virtual stability lab', Icons.biotech_outlined, [
        const Text('First-order degradation of the active (e.g. glabridin): C = C₀·e^(−kt). Temperature follows the Arrhenius equation.'),
        const SizedBox(height: 10),
        Text('Storage temperature: ${tempC.toStringAsFixed(0)} °C'),
        Slider(value: tempC, min: 4, max: 50, divisions: 46, onChanged: (v) => setState(() => tempC = v)),
        SwitchListTile(title: const Text('Exposed to light'), value: light, onChanged: (v) => setState(() => light = v)),
        SwitchListTile(title: const Text('Air / oxygen exposure (loose cap)'), value: oxygen, onChanged: (v) => setState(() => oxygen = v)),
        SwitchListTile(title: const Text('Antioxidant added (vitamin E)'), value: antiox, onChanged: (v) => setState(() => antiox = v)),
      ]),
      Block('Remaining active over 2 years', Icons.show_chart, [
        SizedBox(height: 220, width: double.infinity, child: CustomPaint(painter: DecayPainter(k))),
        const SizedBox(height: 6),
        const Text('Y axis: 50–100% remaining. Red line: 90% (shelf-life limit).', style: TextStyle(fontSize: 12)),
      ]),
      Block('Calculated results', Icons.calculate_outlined, [
        Text('Rate constant k = ${k.toStringAsExponential(2)} day⁻¹'),
        Text('Shelf life t90 = ${t90.toStringAsFixed(0)} days (${(t90 / 30).toStringAsFixed(1)} months)'),
        Text('Half-life t½ = ${tHalf.toStringAsFixed(0)} days'),
      ]),
      Block('Factors affecting reaction rate', Icons.info_outline, [
        bullet('Temperature: rate roughly doubles per 10 °C rise (Arrhenius).'),
        bullet('Light: photo-oxidation of phenolics such as glabridin.'),
        bullet('Oxygen: oxidation; use airtight, opaque packaging.'),
        bullet('Antioxidants and chelators slow degradation.'),
        bullet('Anhydrous base limits hydrolysis, so oxidation dominates.'),
      ]),
      const Text('Parameters (k at 25 °C, Ea, light/oxygen multipliers) are illustrative. Replace them with values from your own HPLC/UV stability data.',
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 12)),
    ]);
  }
}

class DecayPainter extends CustomPainter {
  final double k;
  DecayPainter(this.k);

  @override
  void paint(Canvas canvas, Size s) {
    const maxT = 730.0;
    double y(double c) => s.height * (100 - c) / 50;
    final grid = Paint()..color = Colors.grey.withOpacity(0.35);
    for (int i = 0; i <= 4; i++) {
      final yy = s.height * i / 4;
      canvas.drawLine(Offset(0, yy), Offset(s.width, yy), grid);
    }
    canvas.clipRect(Offset.zero & s);
    final path = Path();
    for (double t = 0; t <= maxT; t += 5) {
      final c = 100 * exp(-k * t);
      final p = Offset(t / maxT * s.width, y(c));
      t == 0 ? path.moveTo(p.dx, p.dy) : path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(path, Paint()..color = kBrown..style = PaintingStyle.stroke..strokeWidth = 3);
    canvas.drawLine(Offset(0, y(90)), Offset(s.width, y(90)), Paint()..color = Colors.red..strokeWidth = 1.5);
    final t90 = log(10 / 9) / k;
    if (t90 < maxT) {
      canvas.drawCircle(Offset(t90 / maxT * s.width, y(90)), 5, Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(DecayPainter o) => o.k != k;
}

// ---------- Quiz ----------
class QuizPage extends StatefulWidget {
  const QuizPage({super.key});
  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const qs = [
    ['Which licorice compound is lipophilic and dissolves in the oil phase?', 'Glabridin', 'Glycyrrhizin', 'Sucrose', 'Caffeine', '0'],
    ['Which reaction order describes degradation where rate depends on one concentration?', 'First order', 'Zero order only', 'Third order', 'None', '0'],
    ['Which equation links rate constant with temperature?', 'Henderson-Hasselbalch', 'Arrhenius', 'Noyes-Whitney', 'Stokes', '1'],
    ['What does t90 mean?', 'Time to 90% degradation', 'Time to 90% remaining', 'Time to melt', 'Time to dissolve', '1'],
    ['Which packaging best protects the active?', 'Clear open jar', 'Opaque airtight tube', 'Clear loose cap', 'Paper wrap', '1'],
  ];
  int idx = 0, score = 0;
  int? picked;

  @override
  Widget build(BuildContext context) {
    if (idx >= qs.length) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Icon(Icons.emoji_events, size: 64, color: kBrown),
          Text('Score: $score / ${qs.length}', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          FilledButton(onPressed: () => setState(() { idx = 0; score = 0; picked = null; }), child: const Text('Play again')),
        ]),
      );
    }
    final q = qs[idx];
    final correct = int.parse(q[5]);
    return ListView(padding: const EdgeInsets.all(16), children: [
      LinearProgressIndicator(value: idx / qs.length),
      const SizedBox(height: 16),
      Text('Question ${idx + 1}', style: Theme.of(context).textTheme.labelLarge),
      Text(q[0], style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      for (int i = 0; i < 4; i++)
        Card(
          color: picked == null ? null : (i == correct ? Colors.green.shade100 : (i == picked ? Colors.red.shade100 : null)),
          child: ListTile(
            title: Text(q[i + 1]),
            onTap: picked != null ? null : () => setState(() { picked = i; if (i == correct) score++; }),
          ),
        ),
      if (picked != null)
        FilledButton(onPressed: () => setState(() { idx++; picked = null; }), child: Text(idx == qs.length - 1 ? 'Finish' : 'Next')),
    ]);
  }
}