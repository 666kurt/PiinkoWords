import AVFoundation

class AudioManager: ObservableObject {
    static let shared = AudioManager()
    private var players: [String: AVAudioPlayer] = [:]
    
    @Published var isPlaying: Bool = false
    
    private init() {}
    
    func loadSound(named soundName: String, withExtension ext: String) {
        guard let url = Bundle.main.url(forResource: soundName, withExtension: ext) else {
            print("Не удалось найти аудиофайл \(soundName).\(ext)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            players[soundName] = player
        } catch {
            print("Ошибка при создании аудиоплеера для \(soundName): \(error.localizedDescription)")
        }
    }
    
    func playSound(named soundName: String, loop: Bool = false) {
        guard let player = players[soundName] else {
            print("Аудиоплеер для \(soundName) не найден. Убедитесь, что вызвали loadSound() перед воспроизведением.")
            return
        }
        
        player.numberOfLoops = loop ? -1 : 0
        player.play()
        isPlaying = true
    }
    
    func stopSound(named soundName: String) {
        guard let player = players[soundName] else {
            print("Аудиоплеер для \(soundName) не найден.")
            return
        }
        
        if player.isPlaying {
            player.stop()
            isPlaying = false
        }
    }
    
    func stopAllSounds() {
        for player in players.values {
            player.stop()
        }
        isPlaying = false
    }
    
    func toggleSound(named soundName: String, loop: Bool = false) {
        guard let player = players[soundName] else {
            print("Аудиоплеер для \(soundName) не найден.")
            return
        }
        
        if player.isPlaying {
            stopSound(named: soundName)
        } else {
            playSound(named: soundName, loop: loop)
        }
    }
}
