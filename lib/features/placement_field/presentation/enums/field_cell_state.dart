enum FieldCellState {
  empty,
  occupied,
  ;

  int get code => switch (this) {
    FieldCellState.empty => 0,
    FieldCellState.occupied => 1,
  };
}

