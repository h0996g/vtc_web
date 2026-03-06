import 'package:equatable/equatable.dart';
import '../../domain/entities/gift_card_entity.dart';

abstract class GiftCardState extends Equatable {
  const GiftCardState();

  @override
  List<Object?> get props => [];
}

class GiftCardInitial extends GiftCardState {
  const GiftCardInitial();
}

class GiftCardLoading extends GiftCardState {
  const GiftCardLoading();
}

class GiftCardLoaded extends GiftCardState {
  const GiftCardLoaded(this.giftCards);

  final List<GiftCardEntity> giftCards;

  @override
  List<Object?> get props => [giftCards];
}

class GiftCardCreating extends GiftCardState {
  const GiftCardCreating();
}

class GiftCardCreated extends GiftCardState {
  const GiftCardCreated(this.giftCard);

  final GiftCardEntity giftCard;

  @override
  List<Object?> get props => [giftCard];
}

class GiftCardError extends GiftCardState {
  const GiftCardError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
