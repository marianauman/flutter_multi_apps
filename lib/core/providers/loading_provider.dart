import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoadingProviderState {
  final bool isLoading;
  final bool refreshBarrier;

  LoadingProviderState({this.isLoading = false, this.refreshBarrier = false});

  LoadingProviderState copyWith({
    bool? isLoading,
    bool? refreshBarrier,
  }) {
    return LoadingProviderState(
      isLoading: isLoading ?? this.isLoading,
      refreshBarrier: refreshBarrier ?? this.refreshBarrier,  
    );
  }
}

class LoadingNotifier extends StateNotifier<LoadingProviderState> {
  static final LoadingNotifier _instance = LoadingNotifier._();
  factory LoadingNotifier() => _instance;

  LoadingNotifier._() : super(LoadingProviderState());

  void show() {
    state = state.copyWith(isLoading: true);
  }

  void hide() {
    state = state.copyWith(isLoading: false);
  }

  void showRefreshBarrier() {
    state = state.copyWith(refreshBarrier: true);
  }

  void hideRefreshBarrier() {    
    state = state.copyWith(refreshBarrier: false);
  }
}

final loadingProvider = StateNotifierProvider<LoadingNotifier, LoadingProviderState>((ref) {
  return LoadingNotifier();
});
