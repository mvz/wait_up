require 'gir_ffi-gtk3'

module WaitUp
  # Main Wait Up application class
  class Application
    def initialize
      setup_gui
      connect_signals
      @win.show_all
    end

    private

    def connect_signals
      connect_key_press_event_signal
      connect_destroy_signal
    end

    def connect_destroy_signal
      @win.signal_connect('destroy') { Gtk.main_quit }
    end

    def connect_key_press_event_signal
      @win.signal_connect 'key-press-event' do |_wdg, evt, _ud|
        handle_key(evt) if evt.state == :control_mask
        false
      end
    end

    def handle_key(evt)
      case evt.keyval
      when 'q'.ord
        @win.destroy
      end
    end

    def setup_gui
      @win = Gtk::Window.new :toplevel
    end
  end
end
