import 'package:flutter/material.dart';
import 'package:flutter_application_2/star_rating.dart';
import 'package:flutter_application_2/tv_show_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class TvShowFormScreen extends StatefulWidget {
  const TvShowFormScreen({super.key, this.tvShow});

  final TvShow? tvShow;

  @override
  State<TvShowFormScreen> createState() => _TvShowFormScreenState();
}

class _TvShowFormScreenState extends State<TvShowFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _streamController = TextEditingController();
  final _summaryController = TextEditingController();
  var _rating = 0;

  @override
  void initState() {
    super.initState();
    if (widget.tvShow != null) {
      _titleController.text = widget.tvShow!.title;
      _streamController.text = widget.tvShow!.stream;
      _summaryController.text = widget.tvShow!.summary;
      _rating = widget.tvShow!.rating;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _streamController.dispose();
    _summaryController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newTvShow = TvShow(
        title: _titleController.text,
        stream: _streamController.text,
        rating: _rating,
        summary: _summaryController.text,
      );

      if (widget.tvShow != null) {
        // Modo edição
        context.read<TvShowModel>().editTvShow(
          widget.tvShow!,
          newTvShow,
          context,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Série editada com sucesso!'),
            duration: Duration(seconds: 3),
          ),
        );
        _navigateBack();
      } else {
        // Modo adição
        context.read<TvShowModel>().addTvShow(newTvShow, context);
        _navigateBack();
      }
    }
  }

  void _navigateBack() {
    // Verifica se pode voltar com Navigator
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      // Se não puder, usa GoRouter para navegar para a tela inicial
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.tvShow != null;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Editar Série' : 'Adicionar Série'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _navigateBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Título*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira o título da série';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _streamController,
                  decoration: const InputDecoration(
                    labelText: 'Streaming*',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira a plataforma de streaming';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _summaryController,
                  decoration: const InputDecoration(
                    labelText: 'Resumo*',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                  minLines: 3,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira um resumo da série';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nota', style: theme.textTheme.titleMedium),
                    StarRating(
                      value: _rating,
                      onRatingChanged: (rating) {
                        setState(() {
                          _rating = rating;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                  ),
                  child: Text(
                    isEditing ? 'SALVAR ALTERAÇÕES' : 'ADICIONAR SÉRIE',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
