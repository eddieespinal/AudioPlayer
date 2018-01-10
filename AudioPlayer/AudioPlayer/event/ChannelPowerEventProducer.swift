class ChannelPowerEventProducer: EventProducer {
    var eventListener: EventListener?
    var player: AVPlayer?
    private var timeObserver: Any?
    
    enum ChannelPowerEvent: Event {
        case powerChanged(left: Float, right: Float)
    }
    
    func startProducingEvents() {
        guard let player = self.player else {
            return
        }
        player.isMeteringEnabled = true
        timeObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMake(1, 2), queue: .main) { [weak self] time in
            if let `self` = self {
                self.eventListener?.onEvent(ChannelPowerEvent.powerChanged(left: player.averagePower(forChannel: 0), right: player.averagePower(forChannel: 1)), generetedBy: self)
            }
        }
    }
    
    func stopProducingEvents() {
        if let timeObserver = timeObserver {
            player?.removeTimeObserver(timeObserver)
        }
        timeObserver = nil
    }
}
