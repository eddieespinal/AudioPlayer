extension AudioPlayer {
    func handleChannelPowerEvent(from producer: EventProducer, with event: ChannelPowerEventProducer.ChannelPowerEvent) {
        switch event {
        case .powerChanged(let left, let right):
            delegate?.audioPlayer(self, didChannelPowerChange: [left, right])
        }
    }
}
