    
    require('UIColor');
    defineClass('ViewController', { simpleTest : function() {
        self.label().setText("你的蓝色 Hello World 被我改成红色了");
        
        var red = UIColor.redColor();
        self.label().setTextColor(red);
    },
    })

