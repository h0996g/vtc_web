import 'package:flutter/material.dart';
import 'package:vtc_web/json/wilaya.dart';
import 'package:vtc_web/core/theme/app_colors.dart';

class WilayaCommuneSelector extends StatefulWidget {
  const WilayaCommuneSelector({
    super.key,
    this.initialWilaya,
    this.initialCommune,
    this.onWilayaChanged,
    this.onCommuneChanged,
    this.wilayaValidator,
    this.communeValidator,
  });

  final String? initialWilaya;
  final String? initialCommune;
  final void Function(String?)? onWilayaChanged;
  final void Function(String?)? onCommuneChanged;
  final String? Function(String?)? wilayaValidator;
  final String? Function(String?)? communeValidator;

  @override
  State<WilayaCommuneSelector> createState() => _WilayaCommuneSelectorState();
}

class _WilayaCommuneSelectorState extends State<WilayaCommuneSelector> {
  String? _selectedWilaya;
  String? _selectedCommune;

  List<String> get _wilayaNames =>
      wilayaData.map((e) => e.keys.first).toList();

  List<String> get _communes {
    if (_selectedWilaya == null) return [];
    final entry = wilayaData.firstWhere(
      (e) => e.keys.first == _selectedWilaya,
      orElse: () => {},
    );
    if (entry.isEmpty) return [];
    return entry[_selectedWilaya]!
        .map((c) => c['name_fr'] ?? '')
        .where((n) => n.isNotEmpty)
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _selectedWilaya = widget.initialWilaya;
    _selectedCommune = widget.initialCommune;
  }

  void _onWilayaChanged(String? value) {
    setState(() {
      _selectedWilaya = value;
      _selectedCommune = null;
    });
    widget.onWilayaChanged?.call(value);
    widget.onCommuneChanged?.call(null);
  }

  void _onCommuneChanged(String? value) {
    setState(() => _selectedCommune = value);
    widget.onCommuneChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AppDropdown(
          label: 'Wilaya',
          hint: 'Select wilaya',
          value: _selectedWilaya,
          items: _wilayaNames,
          onChanged: _onWilayaChanged,
          validator: widget.wilayaValidator,
        ),
        const SizedBox(height: 16),
        _AppDropdown(
          label: 'Commune',
          hint: _selectedWilaya == null
              ? 'Select wilaya first'
              : 'Select commune',
          value: _selectedCommune,
          items: _communes,
          onChanged: _selectedWilaya == null ? null : _onCommuneChanged,
          validator: widget.communeValidator,
        ),
      ],
    );
  }
}

class _AppDropdown extends StatelessWidget {
  const _AppDropdown({
    required this.label,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.validator,
  });

  final String label;
  final String hint;
  final String? value;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      validator: validator,
      onChanged: onChanged,
      isExpanded: true,
      dropdownColor: AppColors.cardBackground,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
      ),
      items: items
          .map(
            (item) => DropdownMenuItem(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
    );
  }
}
